// String manipulation

import UIKit

// "ÁlgÈBra" -> "algebra" conversion ----------------------

extension String {
    
    /** Convert a string with accents into a lowercase String. i.e. "ÁlgÈBra" -> "algebra"
     */
    func stringByRemovingAccents() -> String {
        let accentedString = self as NSString
        let unaccentedString = accentedString.stringByFoldingWithOptions(NSStringCompareOptions.DiacriticInsensitiveSearch, locale: NSLocale(localeIdentifier: "en_US"))
        let lowercaseString = unaccentedString.lowercaseString
        return lowercaseString
    }
    
}

"ÁlgÈBra".stringByRemovingAccents()

// Empty Strings ---------------------------------------------

let anEmptyString = ""
let anEmptyString2 : String? = nil

anEmptyString.isEmpty
anEmptyString2?.isEmpty

// Trimming Strings -------------------------------------------

let myString = "  \t\t  Let's trim all the whitespace  \n \t  \n  "
let trimmedString = myString.stringByTrimmingCharactersInSet(
    NSCharacterSet.whitespaceAndNewlineCharacterSet()
)
