//
//  ConPhoDetailViewController.swift
//  LibraryOfCongress
//
//  Created by Tom Seymour on 10/28/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class ConPhoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var conPhoImageView: UIImageView!
    @IBOutlet weak var conPhoTitleLabel: UILabel!
    @IBOutlet weak var conPhoSubjectsLabel: UILabel!
    
    var thisCongressPhoto: CongressPhoto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailPage()

    }
    
    func loadDetailPage() {
        conPhoTitleLabel.text = thisCongressPhoto.title
        conPhoSubjectsLabel.text = thisCongressPhoto.subjectsString
        print(thisCongressPhoto.images.fullSize)

        ConLibAPI.manager.downloadImage(urlString: thisCongressPhoto.images.fullSize) { (returnedData: Data) in
            DispatchQueue.main.async {
                
                self.conPhoImageView.image = UIImage(data: returnedData)
                self.view.reloadInputViews()
            }
        }
    }
    
}
