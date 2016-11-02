//
//  LibraryOfCongressAPI.swift
//  LibraryOfCongress
//
//  Created by Amber Spadafora on 10/31/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class LibraryOfCongressAPI {
    static let manager = LibraryOfCongressAPI()
    private init() {}
    
    let apiEndPoint: String = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    func getData(from apiEndPoint: String, callback: @escaping (Data?) -> Void) {
        guard let apiUrl = URL(string: apiEndPoint) else {
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        urlSession.dataTask(with: apiUrl) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("There was an error during session: \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
        }
        
        .resume()
    }
    
    
    
    
}
