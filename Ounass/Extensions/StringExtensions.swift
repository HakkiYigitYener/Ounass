//
//  StringExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func attr(color c: UIColor, font f: UIFont, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor : c,
                                                             NSAttributedString.Key.font: f,
                                                             NSAttributedString.Key.paragraphStyle: paragraph])
    }
    
    var A: NSMutableAttributedString {
        get {
            return NSMutableAttributedString(string: self)
        }
    }
}
