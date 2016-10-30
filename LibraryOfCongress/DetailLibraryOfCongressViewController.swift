//
//  DetailLibraryOfCongressViewController.swift
//  LibraryOfCongress
//
//  Created by Ana Ma on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit
import Foundation

class DetailLibraryOfCongressViewController: UIViewController {

    var onePrint: Print?
    
    @IBOutlet weak var fullImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let anyPrint = onePrint{
            APImanager.manager.getData(endpoint: anyPrint.fullImageURLString) { (data) in
                if data != nil {
                    DispatchQueue.main.async {
                        self.fullImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
}
