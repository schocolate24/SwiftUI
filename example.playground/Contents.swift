import UIKit
import SwiftUI


var totalAmount = [Double]()
var sum = 0.0


func total(amount total: Double) -> Double {
    totalAmount.append(total)
    
    sum = totalAmount.reduce(0, +)
        let am = (sum * 100).rounded() / 100
            return am
}

print(total(amount: 9.7))
print(total(amount: 2.5))
print(total(amount: 4.6))


