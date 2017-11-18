//
//  AnimationView.swift
//  Demo21
//
//  Created by Stan on 2017-11-12.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class AnimationView: UIView, CAAnimationDelegate {

    
    var lineWidth: CGFloat = 10
    var lineLength: CGFloat = 100
    var lineMargin: CGFloat = 50
    var animationDuration: Double = 3.0
    
    private var lines: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        
//        transform = CGAffineTransform.identity.rotated(by: rotateAngle(45.0))
    }
    
    func startAnimation() {
//        rotateAnimation()
//        lineToPointAnimation()
        lineZoomInAnimation()
//        pointToLineAnimation()
    }
    
    fileprivate func setupUI() {
        layoutIfNeeded()
        lineLength = max(frame.width, frame.height)
        lineWidth = lineLength * 0.2
        lineMargin = lineLength * 0.25 + lineWidth * 0.5
        

        let startPoints = [point(lineWidth * 0.5, y: lineMargin),
             point(lineLength - lineWidth * 0.5, y: lineLength - lineMargin),
             point(lineMargin, y: lineLength - lineWidth * 0.5),
             point(lineLength - lineMargin, y: lineWidth * 0.5)]

        
        let endPoints = [point(lineLength - lineWidth * 0.5, y: lineMargin) ,
                         point(lineWidth * 0.5, y: lineLength - lineMargin) ,
                         point(lineMargin, y: lineWidth * 0.5),
                         point(lineLength - lineMargin, y: lineLength - lineWidth * 0.5) ]
        
        let lineColors = [UIColor.colorWithHex(0x9DD4E9),UIColor.colorWithHex(0xF5BD58),UIColor.colorWithHex(0xFF317E),UIColor.colorWithHex(0x6FC9B5)]
        
        for i in 0...3 {
            let line: CAShapeLayer = CAShapeLayer()
            line.lineWidth = lineWidth
            line.lineCap = kCALineCapRound
            line.opacity = 0.8
            line.strokeColor = lineColors[i].cgColor
            
            line.path = creatLinePath(startPoints[i], endPoint: endPoints[i]).cgPath
            
            layer.addSublayer(line)
            lines.append(line)
        }
    }
    

    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }

}
/*
 1,动画旋转了两圈
 2，第一圈旋转结束后，线段变成了点点
 3,第二圈旋转结束的时候，又从点点变成线段
 4,第二圈旋转中，线段向中间靠拢，又恢复原来的距离
 */
extension AnimationView {
    fileprivate func rotateAnimation() {
        let ani = CABasicAnimation.init(keyPath: "transform.rotation.z")
        ani.beginTime = CACurrentMediaTime()
        
        ani.fromValue = rotateAngle(45.0)
        ani.toValue = rotateAngle(45.0 + 360.0 * 2)
        
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.duration = animationDuration
        
        ani.delegate = self
        
        layer.add(ani, forKey: "rotateAnimation")
    }
    
    fileprivate func lineToPointAnimation() {
        let ani = CABasicAnimation.init(keyPath: "strokeEnd")
        ani.beginTime = CACurrentMediaTime()
        
        ani.fromValue = 1.0
        ani.toValue = 0.0
        
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.duration = animationDuration * 0.5
        
        for i in 0...3 {
            lines[i].add(ani, forKey: "lineToPointAnimation")
        }
    }
    
    fileprivate func pointToLineAnimation() {
        let ani = CABasicAnimation.init(keyPath: "strokeEnd")
        ani.beginTime = CACurrentMediaTime() + animationDuration
        
        ani.fromValue = 0.0
        ani.toValue = 1.0
        
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.duration = animationDuration * 0.25
        
        for i in 0...3 {
            lines[i].add(ani, forKey: "pointToLineAnimation")
        }
    }
    
    fileprivate func lineZoomInAnimation() {
        
        for i in 0...3 {
            var keyPath: String
            if i % 2 == 1 {
                keyPath = "transform.translation.y"
            } else {
                keyPath = "transform.translation.x"
            }
            
        let ani = CABasicAnimation.init(keyPath: keyPath)
        
        ani.beginTime = CACurrentMediaTime()
        
        ani.fromValue = 0
            if i % 2 == 1 {
                ani.toValue = -lineLength
            } else {
                ani.toValue = lineLength
            }
        
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.autoreverses = true
        
        ani.duration = animationDuration

            lines[i].add(ani, forKey: "lineZoomInAnimation")

        }
    }
}
extension AnimationView {
    fileprivate func point(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    fileprivate func creatLinePath(_ startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    fileprivate func rotateAngle(_ angle: CGFloat) -> CGFloat {
        return CGFloat(angle * (CGFloat.pi / 180))
    }
}


