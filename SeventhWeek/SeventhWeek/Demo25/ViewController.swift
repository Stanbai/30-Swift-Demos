//
//  ViewController.swift
//  Demo25
//
//  Created by Stan on 2017-11-25.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var itemArray = [UIImageView]()
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: view)
    }()
//    var animator: UIDynamicAnimator!
    var attach: UIAttachmentBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        
        for item in 0...5 {
            let imageView = UIImageView.init(image:UIImage.init(named: "80"))
            imageView.frame = CGRect(x: item * 60, y: 200, width: 30, height: 30)
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 15
            view.addSubview(imageView)
            
            itemArray.append(imageView)
        }
        
        
        //    物体属性
        let itemsBehavior = UIDynamicItemBehavior(items: itemArray)
        itemsBehavior.angularResistance = 0.6
        itemsBehavior.density = 10
        itemsBehavior.elasticity = 0.6
        itemsBehavior.friction = 0.3
        itemsBehavior.resistance = 0.3
        
        animator.addBehavior(itemsBehavior)
        
        
        //        重力
        let gravity = UIGravityBehavior.init(items: itemArray)
        animator.addBehavior(gravity)
        
        //        碰撞
        let collision = UICollisionBehavior.init(items: itemArray)
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        //    吸附力
        if let item = itemArray.first {
            attach = UIAttachmentBehavior.init(item: item, attachedToAnchor: item.center)
            attach.anchorPoint = CGPoint(x: 150, y: 80)
            attach.length = 35
            attach.damping = 1
            attach.frequency = 3
            
            animator.addBehavior(attach)
        }
        
        for i in 1..<itemArray.count {
            let view = itemArray[i]
            let attach = UIAttachmentBehavior(item: view, attachedTo: itemArray[i - 1])
            attach.length = 35
            attach.damping = 1
            attach.frequency = 3
            animator.addBehavior(attach)
        }
        

        let pan = UIPanGestureRecognizer.init(target: self, action:#selector(drag(pan:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc fileprivate func drag(pan: UIPanGestureRecognizer) {
        if (animator.behaviors.contains(attach) == false) {
            animator.addBehavior(attach)
        }
        
        let point = pan.location(in: view)
        attach.anchorPoint = point
        
        if pan.state == .ended {
            animator.removeBehavior(attach)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

