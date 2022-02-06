//
//  NSObjectExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 7.02.2022.
//

import Foundation

extension NSObject {
    public static var className: String { return String(describing: self) }
}
