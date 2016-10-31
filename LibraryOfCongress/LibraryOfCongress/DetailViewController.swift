//
//  DetailViewController.swift
//  LibraryOfCongress
//
//  Created by Ilmira Estil on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var fullImage = ""
    @IBOutlet weak var detail: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageIdentifier = fullImage
        detail.downloadImage(urlString: imageIdentifier)
    }



}
