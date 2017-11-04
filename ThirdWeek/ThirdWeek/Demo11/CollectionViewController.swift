//
//  CollectionViewController.swift
//  Demo11
//
//  Created by Stan on 2017-11-01.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "waterfallItemCell"

class CollectionViewController: UICollectionViewController {

    let default_margin: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView?.collectionViewLayout as? WaterfallLayout {
            layout.delegate = self
            
            collectionView?.contentInset = UIEdgeInsets(top: default_margin, left: default_margin, bottom: default_margin, right: default_margin)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Demo11CollectionViewCell
        cell.imageView.image = UIImage(named: "test_\(indexPath.row % 15)")
    
    
        return cell
    }

    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        //    定义矩阵
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 800
        //    旋转加透视
        transform = CATransform3DRotate(transform, CGFloat.pi / 2, 0, 1, 0)
        
        let cell = cell as! Demo11CollectionViewCell
        cell.imageView.layer.transform = transform
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.imageView.layer.transform = CATransform3DRotate(CATransform3DIdentity, 0, 0, 0, 0)
            
        }


    }

}

//MARK: - WaterfallLayoutDelegate
extension CollectionViewController: WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, HeightForItemAt indexPath: IndexPath) -> CGFloat {
                guard let layout = collectionView.collectionViewLayout as? WaterfallLayout else { return 0 }
        let img = UIImage(named: "test_\(indexPath.row % 15)")
        let imgRect = CGRect(origin: .zero, size: CGSize.init(width: layout.cellWidth, height: CGFloat(MAXFLOAT)))
        let rect = AVMakeRect(aspectRatio: (img?.size)!, insideRect: imgRect)
        return rect.size.height
    }
    

    
    
}
