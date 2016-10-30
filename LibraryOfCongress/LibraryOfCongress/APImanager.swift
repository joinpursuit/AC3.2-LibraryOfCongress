//
//  APImanager.swift
//  LibraryOfCongress
//
//  Created by Ana Ma on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APImanager {
    static let manager: APImanager = APImanager()
    //*****
    private init(){}
    
    func getData(endpoint: String, completion: @escaping ((Data?)->Void)){
        guard let validEndpoint = URL(string: endpoint) else {return}
        let session = URLSession.init(configuration: .default)
        
        session.dataTask(with: validEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil{
                print(error)
            }
            
            guard let validData = data else {
                print(data)
                return
            }
            
            completion(validData)
            
            }.resume()
    }
}
