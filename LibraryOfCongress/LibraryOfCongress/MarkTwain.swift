//
//  MarkTwain.swift
//  LibraryOfCongress
//
//  Created by Marcel Chaucer on 10/29/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation

class MarkTwain {
    
    let title: String
    var thumbPic: String
    let fullImage: String
    let subjectList: [String]
    
    init(title: String, thumbPic: String, fullImage: String, subjectList: [String]) {
        self.title = title
        self.thumbPic = thumbPic
        self.fullImage = fullImage
        self.subjectList = subjectList
    }
}
