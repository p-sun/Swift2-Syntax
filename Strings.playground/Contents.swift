// String manipulation

import UIKit

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