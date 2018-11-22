//
//  AHPinDataGenerator.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.
//

import Foundation
import UIKit

public class AHPinDataGenerator: NSObject {
    static let generator = AHPinDataGenerator()
    let randomPicURL = "http://lorempixel.com/400/200"
    let randomPicHolder = "http://placehold.it/350x150"
    let anotherPlaceHolder = "https://placeimg.com/640/480/any"
    
    let para = "Lorem ipsum"
    
    let userAvatars = ["https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-1.png?alt=media&token=c197a8dc-6176-4af8-98b5-0658a5e0846a",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-2.jpg?alt=media&token=6beea959-af9b-408f-8aed-b5431af943d3",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-2.png?alt=media&token=2bdbc9f6-86de-4899-a5d7-120c960d1c68",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-3.png?alt=media&token=1778371e-d11e-4b62-8123-8390ba7f478a",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-4.jpg?alt=media&token=9668430f-b33f-4f11-8e62-f4505bf1757b",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-100-done.png?alt=media&token=ba219d2b-dc99-4b4d-a661-201e3ce41a60",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-102-done.png?alt=media&token=0acb9659-4c19-49f7-a9d3-cc7ea595a4e4",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-101-done.png?alt=media&token=f2ca4770-47b4-45f5-9765-d5fbfd2b558a",
                       "https://firebasestorage.googleapis.com/v0/b/localfun-c9f46.appspot.com/o/internal-user-icons%2Fuser-icon-103-done.png?alt=media&token=afad647c-b482-41b6-9cd7-441c5c1f958d"]
}

extension AHPinDataGenerator {
    func generateCategories() -> [String] {
        let stringArr = ["Trending", "Everything", "DIY", "Women's Style", "Home", "Beauty", "Food", "Men's style", "Humor", "Travel"]
        return stringArr
    }
    
    
}
