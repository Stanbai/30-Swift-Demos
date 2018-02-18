//
//  ViewController.swift
//  CardTable
//
//  Created by Stan on 2018-02-18.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: CollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card Table"
        setupUI()
    }


}

extension ViewController {
    fileprivate func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        layout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 0)
        layout.scrollDirection = .horizontal
        collectionView = CollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        
        collectionView.layer.contents = UIImage.init(named: "bg.jpg")?.cgImage

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.description())
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.description(), for: indexPath) as! CollectionViewCell
        
        cell.imgView.image = UIImage.init(named: "IMG\(indexPath.row + 1)")
        cell.titleLabel.text = " This is the NO.\(indexPath.row + 1) picture."
        return cell
    }
}

class CollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var imgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height * 0.8))
        imgView.contentMode = .scaleToFill
        
        contentView.addSubview(imgView)
        
        titleLabel = UILabel(frame: CGRect(x: 5, y: imgView.frame.maxY + 5, width: contentView.bounds.width, height: contentView.bounds.height * 0.15))
        contentView.addSubview(titleLabel)
        
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionView: UICollectionView {

}
