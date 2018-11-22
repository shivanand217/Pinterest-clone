//
//  AHCollectionVC.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.
//  Copyright © 2018 stopstalk. All rights reserved.
//

import Foundation
import UIKit

class AHCollectionVC: UICollectionViewController {
    
    let layoutRouter = AHLayoutRouter()
    
    fileprivate(set) lazy var delegateCenter: AHDelegatesCenter = {[weak self] () -> AHDelegatesCenter in
        return AHDelegatesCenter(collectionVC: self!)
    }()
    
    fileprivate(set) lazy var dataSourceCenter: AHDataSourceCenter = {[weak self] () -> AHDataSourceCenter in
        return AHDataSourceCenter(collectionVC: self!)
    }()
    
    fileprivate(set) var delegates = [UICollectionViewDelegate]()
    fileprivate(set) var dataSources = [UICollectionViewDataSource]()
    fileprivate(set) var generalDelegates = [UICollectionViewDelegate]()
    
    var layoutArray: [UICollectionViewLayout] {
        return self.layoutRouter.layoutArray
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layoutRouter)
        collectionView?.delegate = delegateCenter
        collectionView?.dataSource = dataSourceCenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView?.setCollectionViewLayout(layoutRouter, animated: false)
        collectionView?.delegate = delegateCenter
        collectionView?.dataSource = dataSourceCenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
