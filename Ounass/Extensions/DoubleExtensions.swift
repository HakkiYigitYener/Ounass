//
//  StringExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation

extension Double {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.numberStyle = .currency
        
        if let formattedPriceAmount = formatter.string(from: NSNumber.init(value: self)) {
            return "\(formattedPriceAmount) AED"
        }
        else {
            return "- AED"
        }
    }
}
