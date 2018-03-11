//
//  AutoScrollView.swift
//  AutoScrollView
//
//  Created by Stan on 2018-03-11.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class AutoScrollView: UIView {
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var timer: Timer!
    
    private var currentIndex = 0
    private let autoScrollInterval: TimeInterval = 1.5
    
    var imageNames: [String]! {
        didSet {
            if imageNames.count < 2 {
                scrollView.isScrollEnabled = false
                pageControl.isHidden = true
                
                if let imageName = imageNames.first {
                    let imageView = UIImageView(image: UIImage.init(named: imageName))
                    imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                    scrollView.addSubview(imageView)
                }
                
                
                return
            }
            
            
            for (index,imageName) in imageNames.enumerated() {
                if index == 0 {
                    
                    let prepareIV = UIImageView(image: UIImage.init(named: imageNames.last!))
                    prepareIV.frame = CGRect(x: 0.0 * self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                    scrollView.addSubview(prepareIV)
                    
                    
                }
                
                if index == imageNames.count - 1 {
                    let prepareIV = UIImageView(image: UIImage.init(named: imageNames.first!))
                    prepareIV.frame = CGRect(x: CGFloat(index + 2) * self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                    scrollView.addSubview(prepareIV)
                    
                    
                }
                
                let imageView = UIImageView(image: UIImage.init(named: imageName))
                imageView.frame = CGRect(x: CGFloat(index + 1) * self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                scrollView.addSubview(imageView)
                
                imageView.contentMode = .scaleAspectFill
                imageView.isUserInteractionEnabled = true
                
                
            }
            
            scrollView.contentSize = CGSize(width: CGFloat(imageNames.count + 2) * self.bounds.size.width, height: self.bounds.size.height)
            scrollView.setContentOffset(CGPoint.init(x: self.bounds.size.width, y: 0), animated: true)
            pageControl.numberOfPages = imageNames.count
            
            setupTimer()

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

extension AutoScrollView {
    fileprivate func setupPageControl() {
        pageControl = UIPageControl.init()
        pageControl.center = CGPoint(x: self.center.x, y: self.frame.size.height - 15)
        pageControl.bounds.size = CGSize(width: self.bounds.size.width, height: 15)
        
        self.addSubview(pageControl)
        
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPage = 0
        
        pageControl.isEnabled = true
    }
    
    fileprivate func setupTimer() {
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: autoScrollInterval, repeats: true, block: { [weak self](_) in
                self?.scrollToNext()
            })
        } else {
            timer = Timer.scheduledTimer(timeInterval: autoScrollInterval, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        }

    }
}


extension AutoScrollView: UIScrollViewDelegate {
    @objc fileprivate func scrollToNext() {
        
        switch currentIndex {
        case 0...imageNames.count - 1:
            scrollView.setContentOffset(CGPoint.init(x: CGFloat(currentIndex + 2) * self.bounds.size.width, y: 0), animated: true)
        default:
            return
        }
    }
    
    
    fileprivate func setupScrollView() {
        scrollView = UIScrollView.init(frame: self.frame)
        self.addSubview(scrollView)
        
        scrollView.backgroundColor = UIColor.green
        
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        
        // default NO. if YES, try to lock vertical or horizontal scrolling while dragging
        scrollView.isDirectionalLockEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
    }
    
    //    MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page = lroundf(Float(scrollView.contentOffset.x / scrollView.bounds.size.width)) - 1
        currentIndex = page
        pageControl.currentPage = page
        if page < 0 {
            scrollView.setContentOffset(CGPoint.init(x: CGFloat(imageNames.count) * self.bounds.size.width, y: 0), animated: false)
        }
        
        if page >= imageNames.count {
            page = 0
            pageControl.currentPage = 0
            scrollView.setContentOffset(CGPoint.init(x: self.bounds.size.width, y: 0), animated: false)
        }
        print(page)
    }
}


