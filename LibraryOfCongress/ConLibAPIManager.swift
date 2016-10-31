//
//  ConLibAPIHelper.swift
//  LibraryOfCongress
//
//  Created by Tom Seymour on 10/27/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

class ConLibAPI {
    
    static let manager = ConLibAPI()
    private init() {}
    
    let endPoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    func getData(endPoint: String, callback: @escaping (Data?)->Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered error durring session:   \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
    
    func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
        guard let imageURL = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered!: \(error!)")
            }
            guard let imageData = data else { return }
            callback(imageData)
            
            }.resume()
    }

}
