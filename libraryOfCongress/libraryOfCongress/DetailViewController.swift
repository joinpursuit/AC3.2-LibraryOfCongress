//
//  DetailViewController.swift
//  libraryOfCongress
//
//  Created by Erica Y Stevens on 10/31/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var congressPicFullImageVIew: UIImageView!
    @IBOutlet weak var congressSubjectsLabel: UILabel!
    @IBOutlet weak var detailViewTitleLabel: UILabel!
    var subjectsListText = ""
    var congressPicTitleText = ""
    var fullImageURLString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.congressSubjectsLabel.text = "Subjects: \n\n\(subjectsListText)"
        self.detailViewTitleLabel.text = congressPicTitleText
        if let url = URL(string: fullImageURLString) {
        self.congressPicFullImageVIew.loadImageUsing(url: url)
        } else {
            print("String was unable to be converted")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
