//
//  DetailVC.swift
//  Demo13
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var image: UIImage! {
        didSet {
            setupUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var imgView: UIImageView = {
        let iv = UIImageView.init(frame: view.bounds)
        return iv
    }()
    
    
    fileprivate func setupUI() {
        
        view.addSubview(imgView)
        print(imgView.frame)
        imgView.backgroundColor = UIColor.lightGray
    }

}

extension DetailVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return CustomPopTransion()
        } else {
            return nil
        }
    }

}
