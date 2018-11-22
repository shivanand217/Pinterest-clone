//
//  Constants.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.

import Foundation
import UIKit

let AHNumberOfColumns: Int = 2
let AHCellPadding : CGFloat = 8.0
let AHNoteFont: UIFont = UIFont.boldSystemFont(ofSize: 15.0)
let AHUserAvatarHeight: CGFloat = 50.0

let AHPinCellIdentifier = "AHPinCell"
let AHPinContentCellIdentifier = "AHPinContentCell"
let AHDiscoverNavCellID = "AHDiscoverNavCell"
let AHPageCellID = "AHPageCell"
let AHCategoryCellID = "AHCategoryCell"
let AHTablePageCellID = "AHTablePageCell"

// Header and Footer are the total height, not their subviews' sizes, i.e. AHRefreshHeader and AHRefreshFooterSize
let AHHeaderKind: String = "AHHeaderKind"
let AHFooterKind: String = "AHFooterKind"
let AHPinLayoutHeaderKind: String = "AHPinLayoutHeaderKind"
let AHPinLayoutHeaderHeight: CGFloat = 44.0

let AHPinNavBarKind: String = "AHPinNavBarKind"
let AHPinNavBarHeight: CGFloat = 44.0


let AHHeaderHeight: CGFloat = 80
let AHFooterHeight: CGFloat = 50

// Header and Footer's coorsponding subviews -- the refresh views for animations
let AHRefreshHeaderSize: CGSize = CGSize(width: 40, height: 40)
let AHRefreshFooterSize: CGSize = CGSize(width: 40, height: 40)

// Refresh is triggerd by pulling down 70% or more of AHHeaderHeight
let AHHeaderShouldRefreshRatio: CGFloat = 0.5

// The collectionView within AHPinVC
let AHCollectionViewInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: AHFooterHeight + 8, right: 5)


