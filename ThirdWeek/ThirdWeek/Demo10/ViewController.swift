//
//  ViewController.swift
//  Demo10
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

let HW = UIScreen.main.bounds.size.width
let numberOfItem: CGFloat = 2
let defaultMargin: CGFloat = 5
let cellWithReuseIdentifier = "cellWithReuseIdentifier"

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Collection View"
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        let itemW = (HW - (numberOfItem + 1) * defaultMargin) / numberOfItem
        layout.itemSize = CGSize(width: itemW, height: itemW)
        
        layout.minimumLineSpacing = defaultMargin
        layout.minimumInteritemSpacing = defaultMargin
        
        layout.sectionInset = UIEdgeInsets(top: defaultMargin, left: defaultMargin, bottom: defaultMargin, right: defaultMargin)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
            

        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellWithReuseIdentifier)
        
        self.view.addSubview(collectionView)
        
    }
}


//    MARK: - DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellWithReuseIdentifier, for: indexPath) as! CustomCell
        cell.imgView.image = UIImage(named: "\(indexPath.row % 7)")
        
        return cell
    }
    
}
