//
//  APIRequestManager.swift
//  LibraryOfCongress
//
//  Created by Annie Tung on 10/29/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func getAPIPoint(apiEndPoint: String, callback: @escaping ((Data?) -> Void)) {
        
        guard let url: URL = URL(string: apiEndPoint) else { return }
        
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error encountered at \(error)")
            }
            
            guard let validData = data else { return }
            callback(validData)
            
            }.resume()
    }
}
