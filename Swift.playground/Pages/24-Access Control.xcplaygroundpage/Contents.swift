//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//:Access Control

//:Modules and Source Files
/*:
Swift's access control model is based on the concept of modules and source files.

A module is a single unit of code distribution ---a framework or application that is built and shipped as a single unit and that can be imported by another module with Swift's import keyword.

Each build target (such as an app bundle or framework) in Xcode is treated as a separate module in Swift. If you group together aspects of your app's code as a stand-alone framework --- perhaps to encapsulate and reuse that code across
multiple applications ---then everything you define within that framework will be part of a separate module when it is imported and used within an app, or when it is used within another framework.

A source file is a single Swift source code file within a module (in effect, a single file within app or framework). Although it is common to define individual types in separate source files, a single source file can contain defintion for multiple types, functions, and so on.
*/

//:Access Levels
/*:
* Public access enables entities to be used within any source file from their defining module, and also in a source file from another modeule that imports the defining module. You typically use public access when specifying the public interface to a framework.
* Internal access enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app's or a framework's internal structure.
* Private access restricts the use of an entity to its own defining source file. Use private access to hide the implementation details of a specific piece of functionality.

Note: Private access in Swift differs from private access in most other languages, as it's scoped to the enclosing source file rather than to the enclosing declaration. This means that a type can access any private entities that are defined in the same source file as itself, but an extension cannot access that type's private members if it's defined in a separate source file.
*/

//:Guiding Principle of Access Levels
/*:
Access levels in Swift follow an overall guiding principle: No entity can be defined in terms of another entity that has a lower( more restrictive) access level.
For example:
* A public variable cannot be defined as having an internal or private type, because the type might not be available everywhere that the public variable is used.
* A function cannot have a higher access level that its parameter types and return type, because the function could be used in situations where its constituent types are not available to the surrounding code.

Access Levels for Frameworks: public

Access Levels for Unit Test Target:
A unit test target can access any internal entity, if you mark the import declaration for a product module with the @testable attribute and complie that product module with testing enabled.
*/

//:Access Control Syntax
public class SomePublicClass {}
internal class SomeInternalClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
private func somePrivateFunction() {}

//default access level is internal

//:Tuple Types
/*:
the access level for a tuple type is the most restrictive access level of all types used in that tuple. For example, if you compose a tuple from two different types, one with internal access and one with private access, the access level for that compound tuple type will be private.
*/

//:Function Types
/*:
the access level for a function type is calculated as the most restrictive access level of the function's parameter types and return type. You must specify the access level explicitly as part of the function's definition if the function's calculated access level does not match the contextual default.
*/

//:Enumeration Types
/*:
the individual cases of an enumeration automatically receive the same access level as the enumeration they belong to. you cannot specify a different access level for individual enumeration cases.
*/


//:Raw Values and Associated Values
/*:
the types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration's access level. You cannot use a private type as the raw-value type of an enumeration with an internal access level.
*/

//:Nested Types
/*:
Nested types defined within a private type have an automatic access level of private. Nested types defined within a public type or an internal type have an automatic access level of internal. If you want a nested type within a public type to be publicly available, you must explicitly declare the nested type as public.
*/

//:Subclassing
/*:
you can subclass any class that can be accessed in the current access context. A subclass cannot have a higher access level than its superclass.

you can override any class member (method, property, initializer, or subscript) that is visible in a certain access context.

An override can make an inherited class member more accessible than its superclass version.
*/
public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        
    }
}

/*:
it is even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member, as long as the call to the superclass's member takes place within an allowed access level context.
*/
public class A_ {
    private func someMethod() {}
}

internal class B_: A{
    override internal func someMethod() {
        super.someMethod()
    }
}

/*:
because superclass A_ and subclass B_ are defined in the same source file, it is valid for the B_ implementation of someMethod() to call super.someMethod()
*/

//:Constants, Variables, Properties, and Subscripts
/*:
a constant, variable, or property cannot be more public than its type. It is not valid to write a public property with a private type.
*/

//:Initializers
/*:
custom initializers can be assigned an access level less than or equal to the type that they initialize. The only exception is for required initializers. A required initializer must have the same access level as the class it belongs to.
As with function and method parameters, the types of an initializer's parameters cannot be more private than the initializer's own access level.
Default Initializers
a default initializer has the same access level as the type it initializes, unless that type is defined as public. For a type that is defined as public, the default initializer is considered internal. If you want a public type to be initializable with a no-argument initializer when used in another module, you must explicitly provide a public no-argument initializer yourself as part of the type's definition.
*/

//:Protocol
/*:
if you want to assign an explicit access level to a protocol type, do so at the point that you define the protocol. This enables you to create protocols that can only be adopted within a certain access context.

The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol. you cannot set a protocol requirement to a different access level than the protocol it supports. This ensures that all of the protocol's requirements will be visible on any type that adopts the protocol.

Protocol Inheritance
if you define a new protocol that inherits from an existing protocol, the new protocol can have at most the same access level as the protocol it inherits from. you cannot write a public protocol that inherits from an internal protocol.
*/

//:Extensions
/*:
you can extend a class, structure, or enumeration in any access context in which the class, structure, or enumeration is available. Any type members added in an extension have the same default access level as type members declared in the original type being extended. if you exetend a public or internal type, any new type members you add will have a default access level of internal. if you extend a private type, any new type members you add will have a default access level of private.
alternatively, you can mark an extension with an explicit access level modifier to set a new default access level for all memebers defined within the extension. this new default can still be overridden within the extension for individual type members.

Adding protocol conformance with an extension
you cannot provide an explicit access level modifier for an extension if you are using that extension to add protocol conformance. Instead, the protocol's own access level is used to provide the default access level for ach protocol requirement implementation within the extension.
*/

//:Generics
/*:
the access level for a generic type or generic function is the minimum of the access level of the generic type or function itself and the access level of any type constraints on its type parameters.
*/

//:Type Aliases
/*:
any type aliases you define are treated as distinct types for the purposes of access control. A type alias can have an access level less than or equal to the access level of the type it aliases.
Note:
this rule also applies to type aliases for associated types used to satisfy protocol conformances.
*/












