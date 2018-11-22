//
//  AHNetowrkTool.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.
//

import Foundation
import UIKit

let shouldCacheImage = true

class AHNetworkTool: NSObject {
    static let tool = AHNetowrkTool()
    
    var imageCache = [String: UIImage]()
}

// MARK:- For Discover Stuff
extension AHNetworkTool {
    
    func loadCategoryData(forCategoryName name: String, completion: ((_ dataModels:[AHCategoryDataModel]? )-> ())? ) {
        DispatchQueue.global().async {
            let dataModels = AHPinDataGenerator.generator.loadCategories(categoryName: name)
            DispatchQueue.main.async {
                completion?(dataModels)
            }
        }
    }
    
    func loadCategoryNames(comletion: (([String]?)->())? ) {
        // this is so fake.....
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                let categoryArr = AHPinDataGenerator.generator.generateCategories()
                comletion?(categoryArr)
            }
        }
    }
}

// MARK:- Pin Data Related
extension AHNetworkTool {
    func loadNewData(completion: @escaping ([AHPinViewModel]) -> Swift.Void) {
        // fake networking:)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let arr = AHPinDataGenerator.generator.randomData()
            completion(arr)
        }
    }
}

// MARK:- Image Related
extension AHNetworkTool {
    func requestImage(urlStr: String, completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlStr) else {
            return
        }
        if let catchedImg = imageCache[url.absoluteString] {
            completion(catchedImg)
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                DispatchQueue.main.async {
                    if let data = data, error == nil {
                        if let image = UIImage(data: data) {
                            self.imageCache[url.absoluteString] = image
                            completion(image)
                            return
                        }
                    }
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}

