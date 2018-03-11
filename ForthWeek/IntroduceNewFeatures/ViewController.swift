//
//  ViewController.swift
//  IntroduceNewFeatures
//
//  Created by Stan on 2018-03-11.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isShowNewFeatures = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainPictureUI()
        
        
        if isShowNewFeatures {
            setupNewFeaturesUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController {
    fileprivate func setupMainPictureUI() {
        
       let backUIImageView = UIImageView.init(frame: view.frame)
        view.addSubview(backUIImageView)
        
        backUIImageView.image = UIImage.init(named: "cozyCar")
        backUIImageView.contentMode = .scaleAspectFit
    }
    
    fileprivate func setupNewFeaturesUI() {
        let guideView = NewFeatureView.init(frame: self.view.frame)
        
        guideView.imageNames = loadImageNames()
        self.view.addSubview(guideView)
    }
    
    private func loadImageNames() -> [String] {
    var names = [String]()
        for i in 1...4 {
            names.append("common_h\(i)")
        }
        return names
    }
}

