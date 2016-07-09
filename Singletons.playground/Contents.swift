// Singleton Pattern --------------------------------------

class SomeManager {
    static let sharedInstance = SomeManager()

    // Variables
    var a = 3         // You can initialize the variable
    var b : Int?      // Or you can declare it as an optional and not initiazlize it
    //let b : Int?    // Must use 'var' for optionals, not 'let'
    
    // Since all objects come with a default public initializer in Swift, you need to override your init and make it private to make sure this singleton is unique. 
    // This way, outside objects cannot create their own instances of your class.
    private init() {}
    
    func aPlusFive() -> Int {
        return a + 5
    }

}

SomeManager.sharedInstance.a
SomeManager.sharedInstance.a = 6
SomeManager.sharedInstance.a
SomeManager.sharedInstance.aPlusFive()

// Initialzing variables in a class -----------------------

class SomeClass {
    
    var b : String // If it's not optional, it must be initialized in the initializer
    init() {
        b = "Cat"
    }
}

class SomeClass2 {
    
    var opt : String? // Optionals do not have to be initialized
    var foo : String! // '!' means that you do not need to initialize this variable
                      // But it will crash if you use it and it's not initialized.
    
    func l () {
        print(foo) // nil
        print(opt) // nil
    }
}

let i = SomeClass2()
i.opt
i.foo
// i.l()            // This will crash because we tried to access foo, but foo was not initialized.

/*
 For more on Singletons,
 http://krakendev.io/blog/the-right-way-to-write-a-singleton
 */
