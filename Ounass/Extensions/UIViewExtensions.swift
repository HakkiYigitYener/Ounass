//
//  UIViewExtensions.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation
import UIKit

extension UIView {

    /**
     Rotate a view by specified degrees

     - parameter angle: angle in degrees
     */
    func setRotation(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }

}
