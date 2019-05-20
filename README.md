# Swift Tips
To do or not to do...


## Table of Contents
* [General](#general)
	* [Implicitly Unwrapped Optionals](#implicitly-unwrapped-optionals)
* [String](#string)
	* [String index](#string-index)
	* [Empty string](#empty-string)
	* [String's sequence methods](#string's-sequence-methods)
* [Collection](#collection)
	* [Array vs. ContiguousArray](#array-vs-contiguousarray)
* [UI](#ui)
	* [layoutSubviews](#layoutSubviews)
	* [loadView](#loadView)
	* [viewDidLoad and Friends](#viewDidLoad-and-friends)

## General

### Implicitly Unwrapped Optionals
Why on earth would you use them?

* Reason 1:

	Temporarily, because you are calling Objective-C code that hasn't been audited for nullability.
	
* Reason 2:

	Because a value is **nil** very briefly, for a well-defined period of time, and is then never **nil** again. For example, if you have a two-phase initialization, then by the time your class is ready to use, the implicitly wrapped optionals will all have a value.
	
	This is the reason Xcode/Interface Builder uses them in the view controller lifecycle: in cocoa and cocoa touch, view controllers create their view lazily, so their exists a time window - after a view controller has been initialized but before it has loaded its view - when the view objects its outlets reference have not been created.

## String

### String index

**Preferred**:

```swift
let string = "welcome aboard!"
string[string.startIndex] //"w"
string[string.index(after:string.startIndex)] // "e"
string[string.index(string.startIndex, offsetBy:4)] // "o"
```

**Not Preferred**:

```swift
// Accidentally quadratic
for i in 0..< string.count {
	let c = string[i]
}
```


### Empty string

**Preferred**:

```swift
// O(1)
string.isEmpty
```

**Not Preferred**:

```swift
// O(n)
string.count > 0
```

### String's sequence methods

It's useless to use the sequence methods under string type.

**Not Preferred**:

```swift
func shuffled(using:)

func sorted()

func min()/ max()

func lexicographicallyProcedes(_:)

func underestimatedCount()

func enumerated()

```

## Collection

### Array vs. ContiguousArray

If you array's Element type is a class or @objc protocol and you do not need
to bridge the array to NSArray or pass the array to Objective-C APIs

**Preferred**:

```swift
struct ContiguousArray<Element>
```

If the array's Element type is a struct or enumeration, ```Array``` and ```ContiguousArray```
should have similar efficiency.

## UI

### layoutSubviews

You **NEVER** call ``` layoutSubviews``` yourself.

**Not Preferred**:

call ``` layoutSubviews() ``` in your code.

**Preferred**:

Tell ```UIKit``` our layout needs updating with ```setNeedsLayout()``` and
it calls our ```layoutSubviews``` during the next update cycle.

### loadView

A newly created view controller doesn't load its view right away, so the view property is ```nil``` by default.
If you access the view when it's ```nil``` the view controller calls the aptly named ```loadView()``` method to load the view.
This "lazy loading" of the view means it's only loaded when needed.

**Not Preferred**:

call ``` loadView() ``` in your code.

**Preferred**:

If you want to force the loading of the view call ```loadViewIfNeeded()```


Override ```loadView()``` method,

**Not Preferred**:

Don't override ```loadView()``` if you are using Interface Builder to create the view.

**Preferred**:

If you do override ```loadView()``` **DO NOT** call ```super```.


### viewDidLoad and Friends

* ```viewDidLoad```: Called after the view controller has loaded its view but not yet added it to the view hierarchy. Called only once in the life of the view controller.

* ```viewWillAppear```: Called when the view controller's view is about to be added to the view hierarchy. Unlike ```viewDidLoad``` this method can be called multiple times in the life of a view controller.

* ```viewDidAppear```: Called after view controller's view is added to the view hierarchy and displayed on-screen. Like ```viewWillAppear``` this method can be called multiple times and has a corresponding method.

**Not Preferred**:

Assume the size of views are correctly set in the ```viewDidLoad``` and ```viewWillAppear``` methods.

**Preferred**:

Use ```viewWillLayoutSubviews``` and ```viewDidLayoutSubviews``` to manually layout views.
