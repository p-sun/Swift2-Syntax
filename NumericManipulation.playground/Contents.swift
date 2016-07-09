// Numbers

import Foundation

// BEST
let n: Double = 0.93999999999999995
round(100*n)/100
"\(round(100*n)/100)"
print(round(100*n)/100)

// Correct
extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}
let x = Double(0.93999999999999995).roundToPlaces(2)
print(x)

// Not preferred
let pi:Double = 0.93999999999999995
let s = String(format:"%.2f", pi)
Double(s)
print(Double(s)!)
