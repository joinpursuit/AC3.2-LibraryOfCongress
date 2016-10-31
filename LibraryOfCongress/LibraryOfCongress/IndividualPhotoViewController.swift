//
//  IndividualPhotoViewController.swift
//  LibraryOfCongress
//
//  Created by Sabrina Ip on 10/30/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class IndividualPhotoViewController: UIViewController {

    var individualPhoto: Photographs!
    @IBOutlet weak var largePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        largePhoto.downloadImage(urlString: individualPhoto.largePhoto)
        self.title = individualPhoto.title
      
    }
}
