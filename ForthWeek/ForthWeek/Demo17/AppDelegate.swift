//
//  AppDelegate.swift
//  Demo17
//
//  Created by Stan on 2017-11-09.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CAAnimationDelegate {

    var window: UIWindow?

    var mask: CALayer?
    var imageView: UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if let window = window {
            imageView = UIImageView(frame: window.frame)
            imageView?.image = #imageLiteral(resourceName: "twitter")
            window.addSubview(imageView!)
        }
        
//        Setup Mask
        mask = CALayer()
        mask?.contents = #imageLiteral(resourceName: "twitter-mask").cgImage
        mask?.position = (window?.center)!
        mask?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView?.layer.mask = mask
        
//        mask animation
        setupMaskAnimation()
        
//        setup windows's background color and visible
        window?.rootViewController = UIViewController()
        window?.backgroundColor = UIColor.init(red: 70 / 255.0, green: 154 / 255.0, blue: 233 / 255.0, alpha: 1)
        window?.makeKeyAndVisible()
        
//       hide the status bar
    UIApplication.shared.isStatusBarHidden = true
        return true
    }

    func setupMaskAnimation() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.25
        
//        let mask zoom in then zoom out
        if let mask = mask {
            let firstBounds = NSValue.init(cgRect: mask.bounds)
            let secondBounds = NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80))
            let thirdBounds = NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
            keyFrameAnimation.values = [firstBounds,secondBounds,thirdBounds]
        }
        
//        setup each key frame time
        keyFrameAnimation.keyTimes = [0,0.2,1]
        
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
//        add animation to mask
        mask?.add(keyFrameAnimation, forKey: "bounds")
    }
    
//    when animation stop would run this delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView?.layer.mask = nil
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

