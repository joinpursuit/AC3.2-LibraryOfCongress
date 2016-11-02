    //
    //  congressRecord.swift
    //  LibraryOfCongress
    //
    //  Created by Amber Spadafora on 10/31/16.
    //  Copyright © 2016 C4Q. All rights reserved.
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
    
    class CongressRecord {
        
        var title: String
        var subjects: [String]
        var images: Images
        var index: Int
        
        
        
        init(title: String, subjects: [String], images: Images, index: Int) {
            self.title = title
            self.subjects = subjects
            self.images = images
            self.index = index
        }
        
        
        static func createAnArrayOfRecords(from data: Data) -> [CongressRecord]? {
            do {
                let libraryJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let dictionaryContainingLibraryData = libraryJSONData as? [String: Any] else { return nil }
                
                guard let arrayOfLibraryDictionaries = dictionaryContainingLibraryData["results"] as? [[String: Any]] else { return nil }
                
                var allCongressRecords: [CongressRecord] = []
                
                for congressRecordDict in arrayOfLibraryDictionaries {
                    
                    guard let recordTitle = congressRecordDict["title"] as? String else { return nil }
                    print("got the titles")
                    
                    guard let imageDict = congressRecordDict["image"] as? [String: String] else {
                        return nil }
                    print("got the images")
                    
                    guard let recordNo = congressRecordDict["index"] as? Int else { return nil}
                    print("got the recordNo")
                    
                    //gets the individual strings(photo URLs) from a dictionary of strings (image links)
                    
                    guard let thumbnailPhoto = imageDict["thumb"], let fullSizePhoto = imageDict["full"], let squarePhoto = imageDict["square"] else { return nil }
                    
                    
                    
                    
                    //converts the image url stiring into a full url string
                    let fullImageUrlString = getCorrectImageString(fromString: fullSizePhoto)
                    let thumbnailImageUrlString = getCorrectImageString(fromString: thumbnailPhoto)
                    let squarePhotoUrlString = getCorrectImageString(fromString: squarePhoto)
                    
                    
                    //declares a copy of the Images Struct (that holds the different urls for the diff. photos)
                    
                    let imagePack = Images(fullSize: fullImageUrlString, thumbnail: thumbnailImageUrlString, square: squarePhotoUrlString)
                    
                    
                    //creates an array of strings from the "subjects" data
                    let subjectsArray: [String]? = congressRecordDict["subjects"] as? [String]
                    
                    var record: CongressRecord
                    
                    if subjectsArray != nil {
                        record = CongressRecord(title: recordTitle, subjects: subjectsArray!, images: imagePack, index: recordNo)
                        allCongressRecords.append(record)
                    } else {
                        record = CongressRecord(title: recordTitle, subjects: [], images: imagePack, index: recordNo)
                        allCongressRecords.append(record)
                    }
                    print(record.subjects)
                
                    
                }
                
                return allCongressRecords
            }
                
            catch let error as NSError {
                print("Error occurred while parsing data: \(error.localizedDescription)")
            }
            
            return nil
            
        }
        
        func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
            
            guard let imageURL = URL(string: urlString) else { return }
            let session = URLSession.shared
            session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                guard let imageData = data else { return }
                callback(imageData)
                
                }.resume()
        }
}
    
    
            
