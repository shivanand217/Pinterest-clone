//
//  AHDataSourceCenter.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.
//  Copyright © 2018 stopstalk. All rights reserved.
//

import Foundation
import UIKit

class AHDataSourceCenter: NSObject {
    weak var collectionVC: AHCollectionVC?
    
    init(collectionVC: AHCollectionVC) {
        self.collectionVC = collectionVC
    }
}

extension AHDataSourceCenter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // each layout has its own section
        return collectionVC?.layoutArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionVC != nil, collectionVC!.layoutArray.count > 0 else {
            return 0
        }
        guard section < collectionVC!.layoutArray.count else {
            fatalError("section is out of bound")
        }
        
        let dataSource = collectionVC!.dataSources[section]
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionVC != nil else {
            fatalError("collectionVC is nil")
        }
        guard collectionVC!.layoutArray.count > 0 else {
            fatalError("layoutArray is empty")
        }
        guard indexPath.section < collectionVC?.layoutArray.count else {
            fatalError("section is out of bound")
        }
        
        let dataSource = collectionVC!.dataSources[indexPath.section]
        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    /// All supplement attributes will be delivered here. You can differentiate them by their kinds you registered.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard collectionVC != nil else {
            fatalError("collectionVC is nil")
        }
        
        if indexPath.section < collectionVC!.dataSources.count {
            let dataSource = collectionVC!.dataSources[indexPath.section]
            if let view = dataSource.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) {
                return view
            }
        }
        
        fatalError("Not fount item with kind:\(kind) indexPath:\(indexPath)")
    }
    
}
