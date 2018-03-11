//
//  NewFeatureView.swift
//  IntroduceNewFeatures
//
//  Created by Stan on 2018-03-11.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class NewFeatureView: UIView {


    
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    var imageNames: [String]! {
        didSet {
            for (index,imageName) in imageNames.enumerated() {
                
                let imageView = UIImageView(image: UIImage.init(named: imageName))
                imageView.frame = CGRect(x: CGFloat(index) * self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                scrollView.addSubview(imageView)
                
                imageView.contentMode = .scaleAspectFit
                imageView.isUserInteractionEnabled = true
                

            }
            
            scrollView.contentSize = CGSize(width: CGFloat(imageNames.count + 1) * self.bounds.size.width, height: self.bounds.size.height)
            pageControl.numberOfPages = imageNames.count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        setupPageControl()


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewFeatureView {
    fileprivate func setupPageControl() {
        pageControl = UIPageControl.init()
        pageControl.center = CGPoint(x: self.center.x, y: self.frame.size.height - 30)
        pageControl.bounds.size = CGSize(width: self.bounds.size.width, height: 30)
        
        self.addSubview(pageControl)
        
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPage = 0
        
        pageControl.isEnabled = true
    }
}


extension NewFeatureView: UIScrollViewDelegate {
    fileprivate func setupScrollView() {
        scrollView = UIScrollView.init(frame: self.frame)
        self.addSubview(scrollView)
        
        
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
    }
    
//    MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.4999)
        pageControl.currentPage = page

        if page >= imageNames.count {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
        }
    }
}
