//
//  LOCModel.swift
//  LibraryOfCongress
//
//  Created by Harichandan Singh on 10/27/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

enum ParsingErrors: Error {
    case titleError, imageDictError, imageStringError, subjectsError
}

internal struct Results {
    //MARK: - Properties
    var title: String
    var thumbnailImageString: String
    var subjects: [String]
    
    static func turnDataIntoResults(from data:Data) -> [Results]? {
        do{
            //Get JSON Data from request
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let castedDict = jsonData as? [String: Any] else {
                print("There was an error casting from \(jsonData)")
                return nil
            }
            print("Data successfully casted to \(castedDict)")
            
            //Cast Dictionary of JSON Data into an Array
            guard let resultsArray = castedDict["results"] as? [[String: Any]] else {
                print("There was an error casting from \(castedDict)")
                return nil
            }
            
            var allResults: [Results] = []
            
            //Parse data
            for dict in resultsArray {
                guard let title = dict["title"] as? String else {
                    throw ParsingErrors.titleError
                }
                
                guard let imageDict = dict["image"] as? [String: String] else {
                    throw ParsingErrors.imageDictError
                }
                
                guard let thumbnailImageString = imageDict["thumb"]
                    else {
                        throw ParsingErrors.imageStringError
                }
                
                let subjects = dict["subjects"] as? [String]
                
                let thumbnail = Array(thumbnailImageString.characters)
                let x = "https://" + String(thumbnail[2..<thumbnail.count])
                let result = Results(title: title, thumbnailImageString: x, subjects: subjects ?? ["N.A."])
                allResults.append(result)
            }
            return allResults
        }
            
        //Handle errors
        catch ParsingErrors.titleError{
            print("Error: Could not locate title key.")
        }
        catch ParsingErrors.imageDictError{
            print("Error: Could not locate image key.")
        }
        catch ParsingErrors.imageStringError{
            print("Error: Could not locate thumb key.")
        }
        catch ParsingErrors.subjectsError {
            print("Error: Could not locate subjects key.")
        }
        catch {
            print("Error encountered!")
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
