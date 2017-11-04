//
//  WaterfallLayout.swift
//  Demo11
//
//  Created by Stan on 2017-11-01.
//  Copyright © 2017 Stan Guo. All rights reserved.
//自定义Layout
////中文链接：http://www.cocoachina.com/ios/20150831/13247.html


import UIKit

protocol WaterfallLayoutDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, HeightForItemAt indexPath: IndexPath) -> CGFloat
    
}

class WaterfallLayout: UICollectionViewLayout {
    
    weak var delegate: WaterfallLayoutDelegate!
    
    private var numberOfColumns = 2
    private var cellPadding: CGFloat = 5
    
    
    private var cache:[UICollectionViewLayoutAttributes] = []
    
    var cellWidth: CGFloat {
        guard let width = collectionView?.bounds.width else { return 0 }
        return width
    }
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
       return CGSize(width: contentWidth, height: contentHeight)
    }
    
    //    计算每个item的Position, calculate each item position
    override func prepare() {
        //        Only calculate once
        guard cache.isEmpty, let collectionView = self.collectionView else { return }
        
        //PreCalculates the X Offset for each column and adds an array to increment the currently max Y Offset for each column
        
        //each width
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        //Acctually there are just two xOffset
        for column in 0 ..< numberOfColumns {
            xOffset.append(columnWidth * CGFloat(column))
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        //        Iterates through the list of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            
            //Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
            let photoHeight = delegate.collectionView(collectionView, HeightForItemAt: indexPath)
            
            let height = cellPadding + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            //Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
            
        }
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}



