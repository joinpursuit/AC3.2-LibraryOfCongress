//
//  LibraryOfCongress.swift
//  LibraryOfCongress
//
//  Created by Annie Tung on 10/29/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class LibraryOfCongress {
    let title: String
    let creator: String
    let publishDate: String
    let imageURL: String
    
    init(title: String,creator: String, publishDate: String, imageURL: String) {
        self.title = title
        self.creator = creator
        self.publishDate = publishDate
        self.imageURL = imageURL
    }
}
