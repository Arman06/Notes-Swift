//
//  coloredDot.swift
//  Notes
//
//  Created by Арман on 3/8/20.
//  Copyright © 2020 Арман. All rights reserved.
//

import UIKit

class FloatingPlusButton: UIButton {
    
    var verticalLineColor: UIColor = UIColor() {
        didSet{setNeedsDisplay()}
    }
    
    var horizontalLineColor: UIColor = UIColor() {
        didSet{setNeedsDisplay()}
    }
    
    var colorFill: UIColor = UIColor() {
        didSet{setNeedsDisplay()}
    }
    var colorStroke: UIColor = UIColor.clear {
        didSet{setNeedsDisplay()}
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
//        let ovalPath = UIBezierPath(ovalIn: CGRect(x: rect.minX + 2, y: rect.minY + 2, width: rect.width - 4, height: rect.height - 4))
//        ovalPath.lineWidth = 2
//        colorStroke.setStroke()
//        ovalPath.stroke()
        let path = UIBezierPath(ovalIn: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
        colorFill.setFill()
        path.fill()
//        let offset = 6
        let vline = UIBezierPath()
        vline.move(to: CGPoint(x: rect.midX, y: 9))
        vline.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 9))
        vline.close()
        
        verticalLineColor.set()
        vline.lineWidth = 2.5
        vline.stroke()
        
        let hline = UIBezierPath()
        hline.move(to: CGPoint(x: 9, y: rect.midY))
        hline.addLine(to: CGPoint(x: rect.maxX - 9, y: rect.midY))
        hline.close()
        
        horizontalLineColor.set()
        hline.lineWidth = 2.5
        hline.stroke()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

            self.transform = CGAffineTransform.identity

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)


    }


}
