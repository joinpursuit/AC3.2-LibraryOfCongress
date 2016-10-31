//
//  PrintsPhotos.swift
//  CongressPrintsPhotos
//
//  Created by Kadell on 10/29/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation

internal struct PrintsPhotos {

    internal let title: String
    internal let thumbnailUrl: String
    internal let fullImageUrl: String

    static func eachPrintPhoto(data: Data) -> [PrintsPhotos]? {
        do{
            let congressData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let congressDataCasted = congressData as? [String : Any] else {
                print("+++++++++There was an error casting to \(congressData)+++++++++")
                return nil
            }
            
            guard let arrayOfCongress = congressDataCasted["results"] as? [[String: Any]] else {
            print("**********There was an error casting into 2ND Tier*********")
            return nil
            }
             print("**********************Users have been created: We In Here ***************")
            
            var allCongress:[PrintsPhotos] = []
            
            for dict in arrayOfCongress {
                guard let title = dict["title"] as? String else {return nil }
                guard let getImage = dict["image"] as? [String: String] else {return nil}
                guard let thumbNail = getImage["thumb"] else {return nil}
                guard let fullImage = getImage["full"] else {return nil}
              
                let dataOfCongress = PrintsPhotos(title: title, thumbnailUrl: thumbNail, fullImageUrl: fullImage)
                allCongress.append(dataOfCongress)
            }
            return allCongress
        }
        catch{
        print("Error Error Error \(error)")
        }
        
    
        return nil
    }

}
