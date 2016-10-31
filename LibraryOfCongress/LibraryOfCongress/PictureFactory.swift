//
//  PictureFactory.swift
//  LibraryOfCongress
//
//  Created by Marcel Chaucer on 10/29/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class PictureFactory {
var pictures = [MarkTwain]()

    static let manager = PictureFactory()
    private init(){}
    
       
    func loadData() {
        guard let path = Bundle.main.path(forResource: "gov", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
            let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary
            else {
                return
        }
        print("We have some json \(dict)")
        
        guard let markTwainStuff = dict?.value(forKeyPath: "results") as? [[String:Any]]
            else {return}
        
        for differentPictures in markTwainStuff {
            if let title = differentPictures["title"] as? String,
            let subjectList = differentPictures["subjects"] as? [String],
            let allImages = differentPictures["image"] as? [String: Any],
            let thumbNailPic = allImages["thumb"] as? String,
            let fullPic = allImages["full"] as? String
                {
                    let allPics = MarkTwain(title: title, thumbPic: thumbNailPic, fullImage: fullPic, subjectList: subjectList)
                    pictures.append(allPics)
        }
}
}
}
