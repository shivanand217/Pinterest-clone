//
//  AHLayoutRouter.swift
//  Pintrest-Clone
//
//  Created by apple on 21/11/18.
//  Copyright © 2018 stopstalk. All rights reserved.
//

import Foundation
import UIKit

class AHLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var sectionFrame: CGRect = .zero
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! AHLayoutAttributes
        copy.sectionFrame = self.sectionFrame
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let otherObj = object as? AHLayoutAttributes {
            if sectionFrame.equalTo(self.sectionFrame){
                return super.isEqual(otherObj)
            }
        } else {
            return false
        }
        return false
    }
    
}

class AHLayoutRouter: UICollectionViewLayout {
    // fileprivate(set) var layoutArray = [AHLayout]()
    fileprivate(set) var sectionYorigins = [CGFloat]()
}

extension AHLayoutRouter {
    
    func add(layout: AHLayout) {
        layoutArray.append(layout)
        layout.setValue(self, forKey: "layoutRouter")
        invalidateLayout()
    }
    
    func insert(layout: AHLayout, at index: Int) {
        layoutArray.insert(layout, at: index)
        layout.setValue(self, forKey: "layoutRouter")
        invalidateLayout()
    }
    
    func addSupplementLayout(layout: AHLayout) {
        add(layout: layout)
        layout.isGlobel = true
    }
    
    func remove(layout: AHLayout){
        if let index = layoutArray.index(of: layout) {
            layoutArray.remove(at: index)
            invalidateLayout()
        }
    }
    
    /// - returns: the layout's current section
    func layoutSection(layout: AHLayout) -> Int {
        if let index = layoutArray.index(of: layout) {
            return index
        }
        return -1
    }
}

// MARK:- Layout Cycle
extension AHLayoutRouter {
    
    override func prepare() {
        layoutArray.forEach { (layout) in
            layout.prepare()
        }
    }
    
    /// For now, it only supports vertical direction layout. So the width of a contentSize is ignored
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView, layoutArray.count > 0 else {
            return CGSize.zero
        }
        sectionYorigins.removeAll()
        var totalHeight: CGFloat = 0.0
        layoutArray.forEach { (layout) in
            sectionYorigins.append(totalHeight)
            let height = layout.collectionViewContentSize.height
            totalHeight += height
            
        }
        let inset = collectionView.contentInset
        let insetOffset = (inset.left + inset.right)
        let width = collectionView.bounds.width - insetOffset
        return CGSize(width: width, height: totalHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        var currentOffset = CGPoint.zero
        
        // Loop through layouts and make offset for their attributes
        layoutArray.forEach { (layout) in
            if layout.isGlobel {
                if let attrs = layout.layoutAttributesForElements(in: rect){
                    attributes.append(contentsOf: attrs)
                }
            }else{
                let newRect = CGRect(x: rect.origin.x, y: rect.origin.y - currentOffset.y, width: rect.size.width, height: rect.size.height)
                if let attrs = layout.layoutAttributesForElements(in: newRect) {
                    let newAttrs = attrs.map({ (attr) -> UICollectionViewLayoutAttributes in
                        return attr.copy() as! UICollectionViewLayoutAttributes
                    })
                    
                    normalizeAttributes(offset: currentOffset, attributes: newAttrs)
                    attributes.append(contentsOf: newAttrs)
                }
            }
            
            let size = layout.collectionViewContentSize
            currentOffset = CGPoint(x: 0.0, y: currentOffset.y + size.height)
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let sectionOffset = sectionYorigins[indexPath.section]
        let offset = CGPoint(x: 0.0, y: sectionOffset)
        let layout = layoutArray[indexPath.section]
        if let attr = layout.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes {
            normalizeAttributes(offset: offset, attributes: [attr])
            return attr
        }
        
        return nil
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layout = layoutArray[indexPath.section]
        if layout.isGlobel {
            let attr = layout.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
            return attr
        }else{
            let sectionOffset = sectionYorigins[indexPath.section]
            let offset = CGPoint(x: 0.0, y: sectionOffset)
            let layout = layoutArray[indexPath.section]
            if let attr = layout.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes {
                normalizeAttributes(offset: offset, attributes: [attr])
                return attr
            }
        }
        return nil
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        layoutArray.forEach { (layout) in
            layout.invalidateLayout()
        }
    }
}

// MARK:- Private Methods
extension AHLayoutRouter {
    fileprivate func normalizeAttributes(offset: CGPoint, attributes array:[UICollectionViewLayoutAttributes]){
        for attr in array {
            if attr.isKind(of: AHLayoutAttributes.self), let attr = attr as? AHLayoutAttributes {
                attr.sectionFrame = attr.frame
            }
            attr.frame = normalizeAttributes(offset: offset, frame: attr.frame)
        }
    }
    
    fileprivate func normalizeAttributes(offset: CGPoint, frame:CGRect) -> CGRect {
        return CGRect(x: frame.origin.x, y: offset.y + frame.origin.y, width: frame.size.width, height: frame.size.height)
    }
}
