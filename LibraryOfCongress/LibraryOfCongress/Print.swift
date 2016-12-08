//
//  Print.swift
//  LibraryOfCongress
//
//  Created by Ana Ma on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum UserModelParseError : Error {
    case dictionary
    case result
    case dictOfPrint
    case title
    case thumbURLString
    case subjectList
}

class Print {
    let title: String
    let thumbURLString: String
    let fullImageURLString: String
    let subjectList: [String]
    
    init(title: String, thumbURLString: String, fullImageURLString: String, subjectList: [String])  {
        self.title = title
        self.thumbURLString = thumbURLString
        self.fullImageURLString = fullImageURLString
        self.subjectList = subjectList
    }
    
    convenience init? (dict: [String: Any]) throws {
        guard let title = dict["title"] as? String else {
            throw UserModelParseError.title
        }
        guard let image = dict["image"] as? [String: Any],
            let thumbURLString = image["thumb"] as? String,
            let fullImageURLString = image["full"] as? String
            else {
                throw UserModelParseError.thumbURLString
        }
        //http://stackoverflow.com/questions/20294328/unsupported-url-in-nsurlrequest
        let thumbImageURLaddedHTTPString = thumbURLString.replacingOccurrences(of: "//", with: "http://", options: .regularExpression, range: nil)
        let fullImageURLaddedHTTPString = fullImageURLString.replacingOccurrences(of: "//", with: "http://", options: .regularExpression, range: nil)
        let subjectLists = dict["subjects"] as? [String]
        //guard let subjectLists = dictOfPrint["subjects"] as? [String]? else {
        //throw UserModelParseError.subjectList
        //}
        self.init(title: title, thumbURLString: thumbImageURLaddedHTTPString, fullImageURLString: fullImageURLaddedHTTPString, subjectList: subjectLists ?? [])
    }
    
    //must be static func, else it won't work when calling in the view controller
    static func getData(from data: Data) -> [Print]? {
        var prints: [Print] = [Print]()
        do {
            let data : Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictionary : [String: Any] = data as? [String: Any] else {
                throw UserModelParseError.dictionary
            }
            if let result: [[String:Any]] = dictionary["results"] as? [[String:Any]]{
                
                for dictOfPrint in result {
                    guard let p = try Print(dict: dictOfPrint) else {
                        throw UserModelParseError.dictOfPrint
                    }
                    prints.append(p)
                }
            }
            
        }
        catch UserModelParseError.dictionary{
            print("Error in dictionary casting")
        }
        catch UserModelParseError.result {
            print("Error in result casting")
        }
        catch UserModelParseError.title {
            print("Error in title casting")
        }
        catch UserModelParseError.thumbURLString {
            print("Error in thumbURLString casting")
        }
        catch UserModelParseError.subjectList {
            print("Error in subjectList casting")
        }
            // catch with no parameter acts like a default catch case
        catch {
            print("Error encountered with JSONSerialization: \(error)")
        }
        return prints
    }
    //Title and thumb in table view.
    //
    //Full image, title, and subject list on the detail page.
}
