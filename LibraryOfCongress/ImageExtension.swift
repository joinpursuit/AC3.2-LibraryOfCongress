//
//  ImageExtension.swift
//  LibraryOfCongress
//
//  Created by Ilmira Estil on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

//jay's pokedex code
let cacheImage = NSCache<NSString, UIImage>()
extension UIImageView {
    func downloadImage(urlString: String) {
        if let cachedImaged = cacheImage.object(forKey: urlString as NSString) {
            self.image = cachedImaged
            return
        }
        guard let url = URL(string: urlString) else { return }
        var imageData: Data?
        DispatchQueue.global(qos: .background).async {
            do {
                imageData = try Data(contentsOf: url)
            } catch let err {
                print("imageData error ==> \n\(err)")
            }
            guard let data = imageData, let downloadedImage = UIImage(data: data) else { return }
            cacheImage.setObject(downloadedImage, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
