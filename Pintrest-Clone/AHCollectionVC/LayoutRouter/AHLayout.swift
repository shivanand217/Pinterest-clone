//
//  AHLayout.swift
//  Pintrest-Clone
//
//  Created by apple on 21/11/18.
//  Copyright © 2018 stopstalk. All rights reserved.
//

import Foundation
import UIKit

class AHLayout: UICollectionViewLayout {
    
    private(set) weak var layoutRouter: AHLayoutRouter?
    var isGlobal = false
    
    override var collectionView: UICollectionView? {
        return layoutRouter?.collectionView ?? nil
    }
    
    var layoutSection: Int {
        return layoutRouter?.layoutSection(layout: self) ?? -1
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        // do nothing.
    }
}
