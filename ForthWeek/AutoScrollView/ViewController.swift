//
//  ViewController.swift
//  AutoScrollView
//
//  Created by Stan on 2018-03-11.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView: AutoScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        scrollView = AutoScrollView.init(frame: CGRect(x: 0, y: 0, width: 320, height: 180))
        
        scrollView.bounds = CGRect(x: 0, y: 0, width: 320, height: 180)
        scrollView.center = self.view.center
        
        scrollView.imageNames = ["0","1","2","3"]
//        scrollView.imageNames = ["2"]
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



