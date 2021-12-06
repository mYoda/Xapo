// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import UIKit


extension NSNumber {
    var cgFloat: CGFloat {
        return CGFloat(floatValue)
    }
}


extension Double {
    func string(fractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(for: self) ?? "\(self)"
    }
    
    func exponentString(fractionDigits: Int, integerDigits: Int = 6) -> String {
        if self <= pow(10, Double(integerDigits)) &&
            (self == 0 || Int(self * Double(10 * fractionDigits)) / (10 * fractionDigits) > 0) {
            
            return string(minimumFractionDigits: 0, maximumFractionDigits: fractionDigits)
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = fractionDigits
            formatter.maximumIntegerDigits = integerDigits
            //formatter.positiveFormat = "0.#E+0"
            formatter.exponentSymbol = "e"
            return formatter.string(for: self) ?? "\(self)"
        }
    }
    
    func string(minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(for: self) ?? "\(self)"
    }
    
    func toTruncatedString() -> String {
        truncatingRemainder(dividingBy: 1.0) > 0 ? string(fractionDigits: 1) : string(fractionDigits: 0)
    }
    
    var moneyString: String {
        return "$\(self.string(minimumFractionDigits: 0, maximumFractionDigits: 2))"
    }
    
    var abbreviatedMoneyString: String {
        return "$\(self.formatUsingAbbrevation)"
    }
    
    var percentString: String {
        return "\(self.string(fractionDigits: 2))%"
    }
    
    var shortMoneyFormat: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"
        formatter.currencyGroupingSeparator = ","
        formatter.numberStyle = .currency
        return formatter.string(for: self) ?? "\(self)"
    }
}


extension Float {
    var formatUsingAbbrevation: String {
        Double(self).formatUsingAbbrevation
    }
}


extension Double {
    
    var formatUsingAbbrevation: String {
        guard self != 0 else { return "0" }
        
        let numFormatter = NumberFormatter()
        
        typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)
        let abbreviation: Abbrevation
        
        let startValue = abs(self)
        
        if startValue > 1 {
            let abbreviations: [Abbrevation] = [
                (0, 1, ""),
                (1000.0, 1000.0, "K"),
                (100_000.0, 1_000_000.0, "M"),
                (100_000_000.0, 1_000_000_000.0, "G"),
                (100_000_000_000.0, 1_000_000_000_000.0, "T"),
            ]
            
            abbreviation = {
                var prevAbbreviation = abbreviations[0]
                for tmpAbbreviation in abbreviations {
                    if (startValue < tmpAbbreviation.threshold) {
                        break
                    }
                    prevAbbreviation = tmpAbbreviation
                }
                return prevAbbreviation
            }()
        } else {
            let fractionAbbreviations: [Abbrevation] = [
                (0.000_000_000_000_1, 0.000_000_000_001, "p"),
                (0.000_000_000_1, 0.000_000_001, "n"),
                (0.000_000_1, 0.000_001, "µ"),
                (0.000_1, 0.001, "m"),
                (0.1, 1, ""),
            ]
            
            abbreviation = {
                var prevAbbreviation = fractionAbbreviations[0]
                for tmpAbbreviation in fractionAbbreviations {
                    if (startValue < tmpAbbreviation.threshold) {
                        break
                    }
                    prevAbbreviation = tmpAbbreviation
                }
                return prevAbbreviation
            }()
        }
        
        let value = self / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.usesSignificantDigits = true
//        numFormatter.maximumFractionDigits = 0
//        numFormatter.minimumIntegerDigits = 1
        //numFormatter.minimumFractionDigits = 1
//        numFormatter.maximumIntegerDigits = 1
        
        return numFormatter.string(from: NSNumber (value:value))!
    }
}


extension Double {
    var suffixNumber: String {

        var num: Double = self
        
        let clean: (Double) -> String = { value in
            let formatter = NumberFormatter().then {
                $0.maximumFractionDigits = 0
                $0.numberStyle = .decimal
            }
            
            guard let number = formatter.string(from: NSNumber(value: value)) else { return "" }
            return number
        }
        
        let sign = ((num < 0) ? "-" : "" )

        num = fabs(num)

        if (num < 1000.0){
            return "\(sign)\(clean(num))"
        }

        let exp: Int = Int(log10(num) / 3.0 )

        let units: [String] = ["K","M","G","T","P","E"]

        let a = pow(1000.0, Double(exp))
        let roundedNum: Double = (Double(10.0 * num) / a).rounded() / 10.0

        return "\(sign)\(clean(roundedNum))\(units[exp-1])"
    }
}

extension Int {
    var suffixNumber: String {
        Double(self).suffixNumber
    }
}
