//
//  ViewController.swift
//  HoverTab
//
//  Created by Stan on 2018-03-12.
//  Copyright © 2018 Stan Guo. All rights reserved.

import UIKit
import WebKit


class ViewController: UIViewController {

    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tabTop: NSLayoutConstraint!
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var scrollView: UIScrollView!
    
    var stopY: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        let request = URLRequest(url: URL.init(string: "https://www.apple.com/")!)
        webView.load(request)
        
        webView.scrollView.isScrollEnabled = false
        
        webView.navigationDelegate = self
        scrollView.delegate = self
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        
        stopY = 400.0
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let webViewH = webView.scrollView.contentSize.height
        
        webViewHeight.constant = webViewH
        view.layoutIfNeeded()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
       let stopOffsetY = offsetY - stopY
        
        if stopOffsetY <= 0 {
            tabTop.constant = 0
        } else {
            tabTop.constant = stopOffsetY
        }
        
        view.layoutIfNeeded()
    }
}

