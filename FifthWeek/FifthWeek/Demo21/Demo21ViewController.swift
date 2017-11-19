//
//  ViewController.swift
//  Demo21
//
//  Created by Stan on 2017-11-12.
//  Copyright © 2017 Stan Guo. All rights reserved.
//


/*
 1,动画旋转了两圈
 2，第一圈旋转结束后，线段变成了点点
 3,第二圈旋转结束的时候，又从点点变成线段
 4,第二圈旋转中，线段向中间靠拢，又恢复原来的距离
 */
import UIKit

class Demo21ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.startAnimation()
    }
    
    @IBAction func sizeValueChanged(_ sender: UISlider) {
        animationView.transform = CGAffineTransform.identity.scaledBy(x: CGFloat(sender.value), y: CGFloat(sender.value))
    }
    
    @IBAction func durationValueChanged(_ sender: UISlider) {
        animationView.animationDuration = Double(sender.value)
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

