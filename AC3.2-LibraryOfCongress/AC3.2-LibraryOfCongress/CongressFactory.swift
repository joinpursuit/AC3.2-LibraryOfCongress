//
//  CongressFactory.swift
//  AC3.2-LibraryOfCongress
//
//  Created by Madushani Lekam Wasam Liyanage on 10/29/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class CongressFactory {
    
    
    static let manager: CongressFactory = CongressFactory()
    private init() {}
    
    class func makeCongressLibrary(apiEndpoint: String, callback: @escaping ([CongressLibrary]?) -> Void) {
        
        if let validCongressEndpoint: URL = URL(string: apiEndpoint) {
            
            // 1. URLSession/Configuration
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // 2. dataTaskWithURL
            session.dataTask(with: validCongressEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                // 3. check for errors right away
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                
                // 4. printing out the data
                if let validData: Data = data {
                    print(validData) // not of much use other than to tell us that data does exist
                    
                    if let allTheCongressLibrary: [CongressLibrary] = CongressFactory.manager.getCongressLibrary(from: validData) {
                        //to update the UI with data when view loads (otherwise you'll have to manually scroll to get the data
                        print(allTheCongressLibrary)
                        callback(allTheCongressLibrary)
                        
                    }
                }
                
                }.resume()
            
        }
        
    }
    
//    results: [
//    {
//    source_created: "2013-11-06 00:00:00",
//    index: 1,
//    medium: "1 photographic print.",
//    reproduction_number: "LC-DIG-ds-004479 (digital file from original item) LC-USZ62-12468 (b&w film copy neg.)",
//    links: {},
//    title: "Mark Twain's boyhood friends Standing - Noval [i.e. Norval] L. Brady, age 82. Son of James Brady, first mayor of Hannibal, Mo. Dr. B.Q. Stevens, age 85. Boyhood friend of Mark Twain. J.L. Robards, age 84. Boyhood friend of Mark Twain. Sitting - Moses D. Bates, age 84. Son of Moses D. Bates, founder of Hannibal, Mo. Mrs. Elizabeth Frazer, age 84. "The real Becky Thatcher." T.G. Dulaney, age 81. A counter part of Mark Twain /",
//    image: {
//    alt: "digitized item thumbnail",
//    full: "//www.loc.gov/pictures/cdn/service/pnp/ds/04400/04479r.jpg",
//    square: "//cdn.loc.gov/service/pnp/ds/04400/04479_75x75px.jpg",
//    thumb: "//cdn.loc.gov/service/pnp/ds/04400/04479_150px.jpg"
//    },
//    created: "2016-04-20 00:00:00",
//    modified: "2016-04-20 00:00:00",
//    collection: [],
//    creator: "Frazer, Jean Tomlinson, 1894-1969",
//    call_number: "BIOG FILE - Clemens, Samuel Langhorne, 1835-1910--Groups [item] [P&P]",
//    medium_brief: "1 photographic print.",
//    source_modified: "2013-11-06 00:00:00",
//    pk: "2013650184",
//    created_published_date: "1922 June 13.",
//    subjects: []
//    },

    internal func getCongressLibrary(from jsonData: Data) -> [CongressLibrary]? {
        
        do {
            let congressJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let congressJSONCasted: [String : AnyObject] = congressJSONData as? [String : AnyObject],
                let congressArray: [AnyObject] = congressJSONCasted["results"] as? [AnyObject]
                
                else {
                    return nil
            }



            var congressLibrary: [CongressLibrary] = []
            
            congressArray.forEach({ congressObject in
               guard let creatorName: String = congressObject["creator"] as? String,
                   let congressImageDict: [String:String] = congressObject["image"] as? [String:String],
                    let title: String = congressObject["title"] as? String,
                    let subjects: [String] = congressObject["subjects"] as? [String],
                   let congressThumbnailString: String = congressImageDict["thumb"],
             
                   let congressFullImageString: String = congressImageDict["full"]
                    else {return}
                   let thumbString: String = "http:" + congressThumbnailString
                let fullImageString: String = "http:" + congressFullImageString
                congressLibrary.append(CongressLibrary(creator: creatorName, title: title, thumbImageString: thumbString, fullImageSrting: fullImageString, subjectList: subjects))

            })
            return congressLibrary
            
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }

    
    
    
    
    
    
}
