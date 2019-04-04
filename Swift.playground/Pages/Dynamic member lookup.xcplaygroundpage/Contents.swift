import Foundation
//http://www.alwaysrightinstitute.com/swift-dynamic-callable/

@dynamicMemberLookup
public struct EnvironmentTrampoline {
    public subscript(dynamicMember k: String) -> String? {
        return ProcessInfo.processInfo.environment[k]
    }
}


let env = EnvironmentTrampoline()

let path = env.PATH ?? "" //env[dynamicMember: "PATH"]

//navigate the filesystem in swift

@dynamicMemberLookup
public struct ShellPathTrampoline {
    
    let url : URL
    var fm  : FileManager { return FileManager.default }
    
    public subscript(dynamicMember key: String)
        -> ShellPathTrampoline
    {
        let url = { () -> URL in
            let url = self.url.appendingPathComponent(key)
            if !isDirectory(url) { return url }
            return self.url.appendingPathComponent(key, isDirectory: true)
        }()
        return ShellPathTrampoline(url: url)
    }
    
    func isDirectory(_ url: URL) -> Bool {
        var isDir  : ObjCBool = false
        let exists = fm.fileExists(atPath: url.path, isDirectory: &isDir)
        return exists && isDir.boolValue
    }
}

let fsRoot = ShellPathTrampoline(url: URL(fileURLWithPath: "/"))

print(fsRoot.usr.local.bin.python) // <==
// ShellPathTrampoline(url: file:///usr/local/bin/python)

extension ShellPathTrampoline {
    var doesExist : Bool {
        return fm.fileExists(atPath: url.path)
    }
}

@dynamicMemberLookup
public struct ShellTrampoline {
    
    public let root : ShellPathTrampoline
    public var url  : URL { return root.url }
    
    public init(url: URL = URL(fileURLWithPath: "/")) {
        self.root = ShellPathTrampoline(url: url)
    }
    
    public let environment = EnvironmentTrampoline()
    
    public subscript(dynamicMember key: String)
        -> ShellPathTrampoline
    {
        let trampoline = root[dynamicMember: key]
        if trampoline.doesExist { return trampoline }
        return lookupInPATH(key) ?? trampoline
    }
    
    func lookupInPATH(_ k: String) -> ShellPathTrampoline? {
        let searchPath = (environment.PATH ?? "/usr/bin")
            .components(separatedBy: ":")
        
        let testURLs = searchPath.lazy.map {
            ( path: String ) -> URL in
            let testDirURL = URL(fileURLWithPath: path, relativeTo: self.url)
            return testDirURL.appendingPathComponent(k)
        }
        
        let fm = FileManager.default
        for testURL in testURLs {
            let testPath = testURL.path
            var isDir    : ObjCBool = false
            
            if fm.fileExists(atPath: testPath, isDirectory: &isDir) {
                if !isDir.boolValue && fm.isExecutableFile(atPath: testPath) {
                    return ShellPathTrampoline(url: testURL)
                }
            }
        }
        return nil
    }
}

public let shell = ShellTrampoline()

print(shell.python)
// ShellPathTrampoline(url: file:///usr/bin/python)


import Foundation

@dynamicMemberLookup
public struct ObjCRuntime {
    
    public typealias Args = KeyValuePairs<String, Any>
    
    @dynamicCallable
    public struct Callable { // `object.doIt`
        
        let instance : Object
        let baseName : String
        
        @discardableResult
        public func dynamicallyCall(withKeywordArguments arguments: Args)
            -> Object
        {
            guard let target = instance.handle else { return instance }
            
            let stringSelector = arguments.reduce(baseName) {
                $0 + $1.key + ":"
            }
            let selector = sel_getUid(stringSelector)
            
            guard let isa = object_getClass(target),
                let i = class_getInstanceMethod(isa, selector) else {
                    return Object(handle: nil)
            }
            let m = method_getImplementation(i)
            
            var buf = [ Int8 ](repeating: 0, count: 46)
            method_getReturnType(i, &buf, buf.count)
            let returnType = String(cString: &buf)
            
            typealias M0 = @convention(c)
                ( AnyObject?, Selector ) -> UnsafeRawPointer?
            typealias M1 = @convention(c)
                ( AnyObject?, Selector, AnyObject? ) -> UnsafeRawPointer?
            
            let result : UnsafeRawPointer?
            switch arguments.count {
            case 0:
                let typedMethod = unsafeBitCast(m, to: M0.self)
                result = typedMethod(target, selector)
            case 1:
                let typedMethod = unsafeBitCast(m, to: M1.self)
                result = typedMethod(target, selector,
                                     arguments[0].value as AnyObject)
            default:
                fatalError("can't do that count yet!")
            }
            
            if returnType == "@" {
                guard let result = result else {
                    return Object(handle: nil)
                }
                
                let p = Unmanaged<AnyObject>.fromOpaque(result)
                return shouldReleaseResult(of: stringSelector)
                    ? Object(handle: p.takeRetainedValue())
                    : Object(handle: p.takeUnretainedValue())
            }
            return self.instance
        }
        
        private func shouldReleaseResult(of selector: String) -> Bool {
            return selector.starts(with: "alloc")
                || selector.starts(with: "init")
                || selector.starts(with: "new")
                || selector.starts(with: "copy")
        }
    }
    
    @dynamicMemberLookup
    public struct Object {
        
        let handle : AnyObject?
        
        public subscript(dynamicMember key: String) -> Callable {
            return Callable(instance: self, baseName: key)
        }
    }
    
    @dynamicCallable
    @dynamicMemberLookup
    public struct Class {
        let handle : AnyClass?
        
        public subscript(dynamicMember key: String) -> Callable {
            return Callable(instance: Object(handle: self.handle),
                            baseName: key)
        }
        
        @discardableResult
        public func dynamicallyCall(withKeywordArguments args: Args)
            -> Object
        {
            return self
                .alloc()
                .`init`
                .dynamicallyCall(withKeywordArguments: args)
        }
    }
    
    public subscript(dynamicMember key: String) -> Class {
        return Class(handle: objc_lookUpClass(key))
    }
}

public let ObjC = ObjCRuntime() // global
let call = ObjC.NSUserDefaults.alloc()
print(call)

let ud = ObjC.NSUserDefaults.standardUserDefaults()
let domains = ud.volatileDomainNames()
print(domains)


let ma = ObjC.NSArray.alloc().`init`()
let ma2 = ma.arrayByAddingObject("Hello")


