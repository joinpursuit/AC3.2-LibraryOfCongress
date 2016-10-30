//
//  APIRequestManager.swift
//  LibraryOfCongress
//
//  Created by Harichandan Singh on 10/27/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class APIRequestManager {
    //MARK: - Singleton
    static let manager = APIRequestManager()
    private init() {}
    
    let apiEndpoint: String = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    func getData(apiEndpoint: String, callback: @escaping (Data) -> Void){
        
        //Use endpoint to create an URL
        guard let url = URL(string: apiEndpoint) else { return }
        
        //Create URL Session
        let session: URLSession = URLSession(configuration: .default)
        
        
        //Create task from session and URL
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //Error handling
            if error != nil {
                print("Encountered an error: \(error)")
            }
            
           //Get JSON Data
            guard let jsonData = data else { return }
            
            //Store Data in callback to be called in view controller
            callback(jsonData)
            
        }.resume()
    }
}
