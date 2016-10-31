//
//  CongressManager.swift
//  LibraryOfCongress
//
//  Created by Ilmira Estil on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal class APIRequestManager {
 
    
    internal static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    
    func getCongressJdata(endpoint: String, callback: @escaping ((Data) -> Void)){
        
        guard let url = URL(string: endpoint) else { return }
        
        //let session: URLSession = URLSession(configuration: .default)
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //Error handling
            if error != nil {
                print("Encountered an error: \(error)")
            }
            //get data
            guard let validData = data else { return }
            
            callback(validData)
            }.resume()
    }
}


