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
//    override static func staticFunction(){
//        
//    }
    
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
//    override static func classFunctionToBeMakeFinalInImmediateSubclass(){
//        
//    }
}

//--------------------------------------------

/* Stored properties
 
   'static var' can be declared as usual,
    but 'class var' cannot store properties, and thus must be declared as a block.
 
    Same rules apply for being able to override 'class', but not 'static' or final'
*/

class Simple {

    static var myStaticVar = "static var in base"
    static var myStaticVar2: String {
        return "static var2 in base"
    }
    
    final var myFinalVar: String = "final var in base"
    final var myFinalVar2: String {
        return "final var2 in base"
    }
    
    //Class stored properties not yet supported in classes; did you mean 'static'?
//    class var myClassVar1 = "class var1"
    class var myClassVar: String {
        return "class var in base"
    }
    
    var myPlainVar = "plain var in base"
    var myPlainVar2: String {
        return "plain var2 in base"
    }

}

class SubSimple: Simple {
    
    // Error: Cannot override with a store property 'myPlainVar'
//    override var myPlainVar = "static var in subclass"
    override var myPlainVar2: String {
        return "plain var2 in base"
    }
    
    override class var myClassVar: String {
        return "class var in subclass"
    }
}

print(Simple.myStaticVar)       // "static var in base"
print(Simple.myStaticVar2)      // "static var2 in base"
print(Simple.myClassVar)        // "class var in base"
print(SubSimple.myClassVar)     // "class var in subclass"


