//
//  SearchCustomCollectionLayout.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 28/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation
import UIKit

class SearchCustomCollectionLayout: UICollectionViewLayout {
    // MARK:- This section will be same for all
    // Content width may be changed according to your requirement
    private var numberOfColumns = 3
    private var cellPadding = CGFloat(3)
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        //collectionView.bounds.width - (insets.left + insets.right) - (cellPadding * CGFloat(numberOfColumns - 1))
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    //  End of Section
    
    override func prepare() {
        // We want to compute necessary calculation once.
        // cache is empty means we haven't done the coputation
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        // Calculation for normal item
        let itemsPerRow = 3
        // Same height and width for square item
        let normalColumnWidth = contentWidth / CGFloat(itemsPerRow)
        let normalColumnHeight = normalColumnWidth
        
        // Featured item calculation
        let featuredColumnWidth = (normalColumnWidth * 2) + cellPadding
        let featuredColumnHeight = featuredColumnWidth
        
        var xOffsets: [CGFloat] = [CGFloat]()
        
        for item in 0..<6 {
            
            let multiplier = item % 3
            
            let xPos = CGFloat(multiplier) * (normalColumnWidth + cellPadding)
            
            xOffsets.append(xPos)
            
        }
        
        xOffsets.append(0.0)
        
        for _ in 0..<2 {
            
            xOffsets.append(featuredColumnWidth + cellPadding)
            
        }
        
        var yOffsets: [CGFloat] = [CGFloat]()
        
        for item in 0..<9 {
            
            var _yPos = floor(Double(item / 3)) * (Double(normalColumnHeight) + Double(cellPadding))
            
            if item == 8 {
                
                _yPos += (Double(normalColumnHeight) + Double(cellPadding))
                
            }
            
            yOffsets.append(CGFloat(_yPos))
            
        }
        
        let numberOfItemsPerSection: Int = 9
        
        let heightOfSection: CGFloat = 4 * normalColumnHeight + (4 * cellPadding)
        
        var itemInSection: Int = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let xPos = xOffsets[itemInSection]
            
            let multiplier: Double = floor(Double(item) / Double(numberOfItemsPerSection))
            
            let yPos = yOffsets[itemInSection] + (heightOfSection * CGFloat(multiplier))
            
            var cellWidth = normalColumnWidth
            
            var cellHeight = normalColumnHeight
            
            if (itemInSection + 1) % 7 == 0 && itemInSection != 0 {
                
                cellWidth = featuredColumnWidth
                
                cellHeight = featuredColumnHeight
                
            }
            
            let frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = frame
            
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            itemInSection = itemInSection < (numberOfItemsPerSection - 1) ? (itemInSection + 1) : 0
            
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            
            if attributes.frame.intersects(rect) {
                
                visibleLayoutAttributes.append(attributes)
                
            }
            
        }
        
        return visibleLayoutAttributes
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cache[indexPath.item]
        
    }
    
    
}

