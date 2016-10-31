//
//  Congress.swift
//  LibraryOfCongress
//
//  Created by Ilmira Estil on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct Congress {
    internal let imageThumbURL: String
    internal let imageFullURL: String
    internal let description: String
    
    
    static func getCongressData(from data: Data) -> [Congress]? {
        var congressLibrary: [Congress]? = []
        do {
            //jsondata
            let data: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let castedDict: [String:Any] = data as? [String:Any]
            else {
                print("jsonData error: \(data)")
                return nil
            }
            
            guard let resultsDict: [AnyObject] = castedDict["results"] as? [AnyObject] else {
                print("error castedDict \(castedDict)")
                return nil
            }
            
            //parse
            for infoDict in resultsDict {
                //print("resultsDict: \(resultsDict)")
                
                //description
                guard let description: String = infoDict["title"] as? String else {
                    print("error description \(infoDict)")
                    return nil }
                
                //images
                guard
                    let imageDict: [String:Any] = infoDict["image"] as? [String:Any],
                    let imageThumbnail =  imageDict["thumb"] as? String,
                    let imageFull = imageDict["full"] as? String
                    else {
                        print("error imageDict \(infoDict)")
                        return nil
                }
                
                    //fix sillycrappy url addresses for imgs
                let imageThumbURL = "https:" + imageThumbnail
                let imageFullURL = "https:" + imageFull
                
                
                //initialize struct properties
                let congressInfo = Congress(imageThumbURL: imageThumbURL, imageFullURL: imageFullURL, description: description)
                congressLibrary?.append(congressInfo)
                
            }
            
            return congressLibrary
            
        } catch let error as NSError {
            print("Error parsing data: \(error.localizedDescription)")
        }
        return nil
    }
    
}
