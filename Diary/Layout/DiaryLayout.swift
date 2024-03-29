//
//  DiaryLayout.swift
//  Diary
//
//  Created by kevinzhow on 15/2/16.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

var edgeInsets = (screenRect.width - collectionViewWidth)/2.0

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        let itemSize = CGSizeMake(itemWidth, itemHeight)
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = itemSpacing
        self.scrollDirection = .Horizontal
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        let contentOffset = collectionView!.contentOffset

        
        for (index, attributes) in enumerate(layoutAttributes) {
            
            let center = attributes.center
            
            let cellPositinOnScreen = (center.x - itemWidth/2.0) - contentOffset.x
            
            if cellPositinOnScreen >= (edgeInsets - itemWidth/2.0) && cellPositinOnScreen < (edgeInsets + collectionViewWidth ) {
                
                let centerPoint = (collectionViewWidth)/2.0
                
                let positonInVisibleArea = cellPositinOnScreen - edgeInsets
                
                let distanceToCenterPoint = positonInVisibleArea - centerPoint
                
                let visiableArea = centerPoint - itemWidth/3.0
                
                if fabs(distanceToCenterPoint) > visiableArea {
                    
                    let finalDistance = fabs(distanceToCenterPoint) - visiableArea
                    
                    var alpha:CGFloat = 0
                    
                    if distanceToCenterPoint < 0 {
                        var progress = CGFloat(finalDistance/((centerPoint - visiableArea)*2))
                        if progress <= 0.5 {
                            alpha = 1.0
                        } else {
                            alpha = (1.0 - progress)/0.5
                        }

                    }else {
                        alpha = 1.0 - CGFloat(finalDistance/(centerPoint - visiableArea))
                    }
                    
                    attributes.alpha = alpha
                    
                    
                }else {
                    attributes.alpha = 1
                }

                
            } else {
                attributes.alpha = 0
            }
            
            
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
