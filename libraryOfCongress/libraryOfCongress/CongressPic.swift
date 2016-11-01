//
//  CongressPic.swift
//  libraryOfCongress
//
//  Created by Erica Y Stevens on 10/31/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

class CongressPic {
    var title: String
    var fullImageURLString: String
    var thumbnailURLString: String
    var subjects: [String]
    
    init(title: String, fullImageURLString: String, thumbnailURLString: String, subjects: [String]) {
        self.title = title
        self.fullImageURLString = fullImageURLString
        self.thumbnailURLString = thumbnailURLString
        self.subjects = subjects
    }
    
    convenience init?(fromDict dict: [String:Any]) {
        if let title = dict["title"] as? String, let fullImage = dict["full"] as? String, let thumb = dict["thumb"] as? String, let subjects = dict["subjects"] as? [String] {
            self.init(title: title, fullImageURLString: fullImage, thumbnailURLString: thumb, subjects: subjects)
        } else {
            print("Convenience Init Failed")
            return nil
        }
    }
}
