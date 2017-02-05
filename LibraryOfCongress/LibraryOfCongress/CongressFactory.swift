//
//  CongressFactory.swift
//  LibraryOfCongress
//
//  Created by Edward Anchundia on 10/31/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

struct CongressFactory {
    let imageDescription: String
    let imageThumbnail: String
    let imageFull: String
    
    static func getImageInfo(from data: Data) -> [CongressFactory]? {
        
        do {
            let imageJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let imageJSONCasted = imageJSONData as? [String: Any],
            let imageArr = imageJSONCasted["results"] as? [[String: Any]]
                else { return nil }
            
            var imageInfo = [CongressFactory]()
            
            imageArr.forEach({ imageObject in
                guard let imageDes = imageObject["title"] as? String,
                let image = imageObject["image"] as? [String: String],
                let thumbnailImage = image["thumb"],
                let fullImage = image["full"] else { return }
                
                let thumbnailURL = "https:" + thumbnailImage
                let fullImageURL = "https:" + fullImage
                
                let imageDeatil = CongressFactory(imageDescription: imageDes, imageThumbnail: thumbnailURL, imageFull: fullImageURL)
                imageInfo.append(imageDeatil)
            })
            return imageInfo
        }
        catch let error as NSError {
            print("Error while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
}
