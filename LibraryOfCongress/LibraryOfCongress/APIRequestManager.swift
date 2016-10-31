//
//  APIRequestManager.swift
//  LibraryOfCongress
//
//  Created by Edward Anchundia on 10/31/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    init() {}
    
    let apiEndPoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    func getData(comption: @escaping ((Data?) -> Void)) {
        if let validEndPoint: URL = URL(string: apiEndPoint){
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: validEndPoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print("Error encountered: \(error)")
                }
                if let validData: Data = data {
                    print(validData)
                }
            }.resume()
        }
    }
}
