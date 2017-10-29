//
//  ViewController.swift
//  Demo9
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

let HW = UIScreen.main.bounds.size.width
let numberOfItem: CGFloat = 4
let defaultMargin: CGFloat = 5
let cellWithReuseIdentifier = "cellWithReuseIdentifier"

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()

        let itemW = (HW - (numberOfItem + 1) * defaultMargin) / numberOfItem
        let itemH: CGFloat = 100
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
        layout.minimumLineSpacing = defaultMargin
        layout.minimumInteritemSpacing = defaultMargin
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: defaultMargin, left: defaultMargin, bottom: defaultMargin, right: defaultMargin)
        
       let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 150, width: HW, height: itemH * 2 + defaultMargin * numberOfItem), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.lightGray

        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
       let pc = UIPageControl.init(frame: CGRect(x: HW * 0.45, y: 380, width: 50, height: 20))
        pc.numberOfPages = 2
        pc.currentPage = 0
        
        pc.currentPageIndicatorTintColor = UIColor.darkGray
        pc.pageIndicatorTintColor = UIColor.lightGray
        
        pc.isEnabled = false
        
        return pc
    }()
    
    fileprivate func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: cellWithReuseIdentifier)
        
        self.view.addSubview(collectionView)
        
        self.view.addSubview(pageControl)
    }
}


//    MARK: - DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath) as! CollectionCell
        cell.numberLabel.text = indexPath.row.description

        if indexPath.row > 10 {
            cell.backgroundColor = UIColor.clear
            cell.numberLabel.text = nil
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.499
        pageControl.currentPage = Int(page)
    }
}


