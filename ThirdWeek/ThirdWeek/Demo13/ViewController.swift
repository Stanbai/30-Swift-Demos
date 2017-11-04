//
//  ViewController.swift
//  Demo13
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
    var selectedCell: CustomCell?
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokemon"
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
        cell.imgView.image = UIImage(named: "\(indexPath.row % 6)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailVC()
        selectedCell = (collectionView.cellForItem(at: indexPath) as! CustomCell)
        
        detailVC.image = selectedCell?.imgView.image
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return CustomMoveTransion()
        } else {
            return nil
        }
    }
    
    
}

