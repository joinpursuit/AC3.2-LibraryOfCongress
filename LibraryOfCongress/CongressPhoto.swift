//
//  CongressPhoto.swift
//  LibraryOfCongress
//
//  Created by Tom Seymour on 10/27/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

struct Images {
    let fullSize: String
    let thumbnail: String
    let square: String
}

func getCorrectImageString(fromString: String) -> String {
    var correctImageString = "https:"
    for char in fromString.characters {
        correctImageString += String(char)
    }
    return correctImageString
}

class CongressPhoto {
    let title: String
    let subjects: [String]
    let images: Images
    var subjectsString: String {
        var theSubjects = ""
        for subject in self.subjects {
            theSubjects += subject
        }
        return theSubjects
    }
    
    init(title: String, subjects: [String], images: Images) {
        self.title = title
        self.subjects = subjects
        self.images = images
    }
    
    static func returnArrayOfCongressPhotos(from data: Data) -> [CongressPhoto]? {
        do {
            let conLibJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            print("11111111 data")
            guard let conLibDataDict = conLibJSONData as? [String: Any] else { return nil }
            print("22222222 1st Dict")
            guard let arrayOfCongressDicts = conLibDataDict["results"] as? [[String: Any]] else { return nil }
            print("33333333 an array of dicts to loop through")
            
            var allTheCongressPhotos: [CongressPhoto] = []
            
            for congressPhotoDict in arrayOfCongressDicts {
                guard let photoTitle = congressPhotoDict["title"] as? String else { return nil }
                print("44444444 successfully got the title")
                
                guard let imageDict = congressPhotoDict["image"] as? [String: String] else { return nil }
                print("555555555 got an imageDict")
                
                guard let thumbnailString = imageDict["thumb"], let fullImageString = imageDict["full"], let squareString = imageDict["square"] else { return nil }
                
                let correctFullImageString = getCorrectImageString(fromString: fullImageString)
                let correctThumnailImageString = getCorrectImageString(fromString: thumbnailString)
                let correctSquareString = getCorrectImageString(fromString: squareString)
                
                let theseImages = Images(fullSize: correctFullImageString, thumbnail: correctThumnailImageString, square: correctSquareString)
                
                let arrayOfSubjects: [String]? = congressPhotoDict["subjects"] as? [String]
                
                let safeArrayOfSubjects = arrayOfSubjects != nil ? arrayOfSubjects! : ["No subject data with this photograph"]
                
                print("66666666 got the subjects")
                
                let thisCongressPhoto = CongressPhoto(title: photoTitle, subjects: safeArrayOfSubjects, images: theseImages)
                allTheCongressPhotos.append(thisCongressPhoto)
                
            }
            
            return allTheCongressPhotos

        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return nil
    }
    
}
