//
//  CongressPicFactory.swift
//  libraryOfCongress
//
//  Created by Erica Y Stevens on 10/31/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

//This class is used to make the API request and create data objects by parsing JSON
class CongressPicFactory {
    
    //Singleton
    static let manager: CongressPicFactory = CongressPicFactory()
    private init () {}
    
    //Creates object instances
    func getCongressPics(from jsonData: Data) -> [CongressPic]? {
        
        do {
            let congressJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
        
            guard let congressDataObject: [String: AnyObject] = congressJSONData as? [String: AnyObject], let congressDataResultsArrOfDicts: [[String:AnyObject]]  = congressDataObject["results"] as? [[String:AnyObject]] else {
                print("Unable to index into JSON Object")
                return nil
            }
            
            var congressPics = [CongressPic]()
            
            congressDataResultsArrOfDicts.forEach({ congressPic in
                guard let title = congressPic["title"] as? String, let imagesDict = congressPic["image"] as? [String:AnyObject], let subjectsArrayOfDicts = congressPic["subjects"] as? [String] else {
                    return
                }
                
                guard let fullImageURLString = imagesDict["full"] as? String, let thumbnailImageURLString = imagesDict["thumb"] as? String else {
                    return
                }
                
                congressPics.append(CongressPic(title: title, fullImageURLString: fullImageURLString, thumbnailURLString: thumbnailImageURLString, subjects: subjectsArrayOfDicts))
            })
            
            return congressPics
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        return nil
    }
    
}
