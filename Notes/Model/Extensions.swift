//
//  File.swift
//  Notes
//
//  Created by Арман on 1/27/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

extension UIView {
    func createGradientLayer(withRoundedCorners isRounded: Bool, colors: [CGColor]) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        if isRounded {
            gradientLayer.cornerRadius = self.frame.height / 2
        }
        
//        gradientLayer.colors = [UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0).cgColor,
//                                UIColor(red:0.00, green:0.54, blue:1.0, alpha: 1).cgColor,
//                                UIColor(red:0.00, green:0.70, blue:1.0, alpha: 1).cgColor]
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5,y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5,y: 1 )
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        let newColors = [UIColor.purple, UIColor.orange].map { $0.cgColor }
        let gradientChangeAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
        gradientChangeAnimation.duration = 5.0
        gradientChangeAnimation.toValue = newColors
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
    }
}

extension Date {
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
        
    }
}
