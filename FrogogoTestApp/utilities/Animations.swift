// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

extension UIView {
    func shakeAsInvalid() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue   = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        
        self.layer.add(animation, forKey: "shakeAsInvalid")
    }
}
