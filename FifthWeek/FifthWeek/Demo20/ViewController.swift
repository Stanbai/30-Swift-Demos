//
//  ViewController.swift
//  Demo20
//
//  Created by Stan on 2017-11-12.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    fileprivate func setupVideo() {
       let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments.mp4", ofType: nil)!)
            videoFrame = view.frame
            fillMode = .resizeAspectFill
            alwaysRepeat = true
        @IBAction func sizeValueChanged(_ sender: UISlider) {
        }
        sound = true
            startTime = 1.0
            alpha = 1.0
            
            contentURL = url
            view.isUserInteractionEnabled = false
    
        

    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

