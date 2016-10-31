//
//  Stuff.swift
//  LiBrArY oF CONgress
//
//  Created by C4Q on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

func fixURL(theString: String) -> String {
    return "https:" + theString
}

func createSubjectList (arr: [String]) -> String {
    var str = ""
    
    for i in arr {
        str += (i + "\n")
    }
    
    return str
}

struct Stuff {
    
    let imageFull: String
    let imageThumb: String
    let subjectList: String
    let title: String
    
    
    
    static func parseData (data: Data) -> [Stuff]? {
        
        var arr = [Stuff]()
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let congressDict = jsonData as? [String: Any] else {print("json to dict failed")
                return nil}
            guard let results = congressDict["results"] as? [[String:Any]] else {print("dict arr failing")
                return nil}
            for result in results {
                guard let title = result["title"] as? String else {print("title failed")
                    return nil}
                guard let imageDict = result["image"] as? [String: Any], let imageThumb = imageDict["thumb"] as? String, let imageFull = imageDict["full"] as? String else {print("thumb failed")
                    return nil}
                guard let subjectArr = result["subjects"] as? [String]? ?? ["N/A"] else {print("subject shit failed")
                    return nil}
                arr.append(self.init(imageFull: fixURL(theString: imageFull), imageThumb: fixURL(theString: imageThumb), subjectList: createSubjectList(arr: subjectArr), title: title))
            }
            print("working so far")
        }
        catch{
            print(error)
        }
        return arr
    }
    
    
}
