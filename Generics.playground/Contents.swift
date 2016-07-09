//: Playground - noun: a place where people can play

import UIKit

class GenericManager {
    
    
    class func someGenericFunc<TypeModel>(type: TypeModel.Type, s: String) -> String {
        
        String.self
        
        return s
    }

    class func someFunc (s: String) -> String {
        return s
    }
    
    class func returnType () {
        
    }
    
}


class aType {
    
}

GenericManager.someGenericFunc(aType.self, s: "string here")
    
GenericManager.someFunc("asdf")

String.self