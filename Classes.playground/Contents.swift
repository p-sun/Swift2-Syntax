// Classes

/*
'static' and 'class' both associate a method with a class, rather than an instance of a class.
 
 The difference is that subclasses can override 'class' methods; 
    they cannot override 'static' or 'final' methods.
 
 To use 'static' or 'final' class is choice of style. One style would be:
    'static' at super class.
    'final' class to cut off further overrides by a subclass
 */

class A{
    class func classFunction(){
    }
    static func staticFunction(){
    }
    class func classFunctionToBeMakeFinalInImmediateSubclass(){
    }
    
}

A.classFunction()
A.staticFunction()

class B: A {
    
    override class func classFunction(){
        
    }
    
    //Compile Error. Class method overrides a 'final' class method
    override static func staticFunction(){
        
    }
    
    //Lets avoid the function called 'classFunctionToBeMakeFinalInImmediateSubclass' being overriden by subclasses
    
    /* First way of doing it
     override static func classFunctionToBeMakeFinalInImmediateSubclass(){
     }
     */
    
    // Second way of doing the same
    override final class func classFunctionToBeMakeFinalInImmediateSubclass(){
    }
    
}

class C: B{
    //Compile Error. Class method overrides a 'final' class method
    override static func classFunctionToBeMakeFinalInImmediateSubclass(){
        
    }
}

//--------------------------------------------

// 'static var' is fine, but not 'class var'.

class myClass {
    static func myMethod1() {
    }
    class func myMethod2() {
    }
    static var myVar1 = ""
    
    //Compile error. Class stored properties not yet supported in classes; did you mean 'static'?
    class var myVar2 == ""
}

myClass.myMethod1()
myClass.myMethod2()
myClass.myVar1 = "abc"

