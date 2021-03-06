# Swift Tips
To do or not to do...


## Table of Contents
* [General](#general)
	* [Optional, Void, Never](#optional-void-never)
	* [Enum](#enum)
	* [@unknown default](#@unknown-default)
* [Optional](#optional)
	* [Equating Optionals](#equating-optionals)
	* [Implicitly Unwrapped Optionals](#implicitly-unwrapped-optionals)
* [Function](#function)
	* [Overview](#overview)
	* [Lazy Stored Properties](#lazy-stored-properties)
	* [The @escaping Annotation](#the-@escaping-annotation)
* [String](#string)
	* [String index](#string-index)
	* [Empty string](#empty-string)
	* [String's sequence methods](#string's-sequence-methods)
* [Collection](#collection)
	* [Array vs. ContiguousArray](#array-vs-contiguousarray)
	* [Iteration Using forEach](#iteration-using-forEach)
	* [Array and ArraySlice Index](#array-and-arrayslice-index)
* [UI](#ui)
	* [layoutSubviews](#layoutSubviews)
	* [loadView](#loadView)
	* [viewDidLoad and Friends](#viewDidLoad-and-friends)

## General

### Optional, Void, Never

Optional - absence of a thing (nil)
Void - presence of nothing
Never - thing which cannot be

### Enum

Enums are value types

* Enums can have methods, computed properties, and subscripts.
* Methods can be declared mutating or non-mutating.
* You can write extensions for enums.
* Enums can conform to protocols.
* Enums cannot have sorted properties.


### @unknown default

```swift
switch error {
  case .dataCorrupted: ...
  @unknown default:
  // Handle unknown cases.
}
```

```@unknown default``` behaves like normal default clause at runtime, but it's also a signal to the compiler that the default case is only meant to handle enum cases that are unknown at compile time. If the default case matches a case that's known at compile time, we'll still get a warning. This means we can still benefit from exhaustiveness checking when we recompile our program in the future against a newer library interface. If a case got added to the library API since the last update, we'll get warnings to update all our switch statements to explicitly handle the new case. @unknown default gives you the best of both worlds: compile-time exhaustiveness checking, and runtime safety.

## Optinoal

### Equating Optionals

**Preferred**
```swift
let regex = "^Hello$"
if regex.first == "^" { // Match only the start of the string. }
```

**Not Preferred**
```swift
if !regex.isEmpty && regex[regex.startIndex] == "^" { }
```

### Implicitly Unwrapped Optionals
Why on earth would you use them?

* Reason 1:

	Temporarily, because you are calling Objective-C code that hasn't been audited for nullability.
	
* Reason 2:

	Because a value is **nil** very briefly, for a well-defined period of time, and is then never **nil** again. For example, if you have a two-phase initialization, then by the time your class is ready to use, the implicitly wrapped optionals will all have a value.
	
	This is the reason Xcode/Interface Builder uses them in the view controller lifecycle: in cocoa and cocoa touch, view controllers create their view lazily, so their exists a time window - after a view controller has been initialized but before it has loaded its view - when the view objects its outlets reference have not been created.

## Function

### Overview

To understand functions and closures in Swift, you really need to understand three things,
in roughly this order of importance:

1. Functions can be assigned to variables and passed in and out of other functions as arguments,
just as an Int or String can be.

2. Functions can capture variables that exist outside of their local scope.

3. There are two ways of creating functions - either with the ```func``` keyword, or with ```{}```.
Swift calls the latter closure expressions.

### Lazy Stored Properties

```swift
lazy var preview: UIImage = {
  for point in track.record {
    // Do some expensive computation
  }
  return UIImage(//...)
}()
```

it's a closure expression that returns the value we want to store.
When the property is first accessed, the closure is executed, and its return value is stored in the proerty.

Because a lazy variable needs storage, we're require to define the lazy property in the definition of ```class``` or ```struct```. Unlike computed properties, stored properties and stored lazy properties can't be defined in an extension.

If the track property changes, the preview won't automatically get invalidated.

Accessing a lazy property is a mutating operation because the property's initial value is set on the first access. When a struct contains a lazy property, any owner of the struct that accesses the lazy property must therefore declare the variable containing the struct as ```var```, because accessing the property means potentially mutating its container.

Additionally, be aware that the ```lazy``` keyword doesn't perform any thread synchronization. If multiple threads access a lazy property at the same time before the value has been computed, it's possible the computation could be performed more than once, along with any side effects the computation may have.

### The @escaping Annotation

If a closure is stored somewhere to be called later, it is said to be **escaping**. Conversely, closures that never leave a function's local scope are **non-escaping**. With **escaping** closures, the compiler forces us to be explicit about using **self** in closure expressions, because unintentionally capturing **self** strongly is one of the most frequent causes of reference cycles. A non-escaping closure can't create a permanent reference cycle because it's automatically destroyed when the function it's defined in returns.

Closure arguments are non-escaping by default.

```swift
func sortDescriptor<Root, Value>(key: @escaping (Root) -> Value, by areInIncreasingOrder: @escapiong(Value, Value) -> Bool) -> SortDescriptor<Root> {
//something here
}
```

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

### Iteration Using forEach

**Not Preferred**

```swift
//forEach not return
(1..<10).forEach {
number in
print(number)
if number > 2 { return }
}
```

It only returns from the closure itself.


**Preferred**

When you want return out of function, use ```for x in [1,2,3]```

### Array and ArraySlice Index

It's important to keey in mind that slices use the same index as their base collection does to refer to a particular element.
As a consequence, slice indices don't necessarily start at zero. For example, the first emlement of the ```fib[1...]``` slice we created above is at index 1, and accessing ```slice[0]``` by mistake would crash our program with out-of-bounds violation.

***Preferred***

If you work with indices, always base your calculations on the ```startIndex``` and ```endIndex``` properties, even if you're dealing with a plain array where ```0``` and ```count-1``` would also do the trick.

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
