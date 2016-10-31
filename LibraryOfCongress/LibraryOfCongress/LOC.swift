//
//  LOC.swift
//  LibraryOfCongress
//
//  Created by Sabrina Ip on 10/30/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import Foundation

struct Photographs {
    let title: String
    let thumbnailPhoto: String
    let largePhoto: String
    
    
    static func getPhotoInfo(from data: Data) ->[Photographs]? {
        
        do {
            let LocJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let LOCCasted = LocJSONData as? [String: Any],
            let LOCArr = LOCCasted["results"] as? [[String: Any]]
                else {return nil}
            
            var photoInfo = [Photographs]()
            
            LOCArr.forEach({ (photoObject) in
                guard let photoTitle = photoObject["title"] as? String,
                let images = photoObject["image"] as? [String: String],
                let thumbnailImage = images["thumb"],
                    let largeImage = images["full"] else {return}
                
                let thumbnailURL = "https:" + thumbnailImage
                let largeImageURL = "https:" + largeImage
 
                let photoDetails = Photographs(title: photoTitle, thumbnailPhoto: thumbnailURL, largePhoto: largeImageURL)
                photoInfo.append(photoDetails)
            })
            return photoInfo
        }
        catch let error as NSError {
            print("Error occured while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
}
