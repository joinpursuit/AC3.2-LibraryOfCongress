//
//  APIRequestManager.swift
//  LibraryOfCongress
//
//  Created by Sabrina Ip on 10/30/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    init() {}
    
    let apiEndPoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    func getData(completion: @escaping ((Data?)->Void)) {
        if let validEndPoint: URL = URL(string: apiEndPoint) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print("Error encountered!: \(error)")
                }
                if let validData: Data = data {
                    print(validData)
                    completion(validData)
                }
                }.resume()
        }
    }
    
}
