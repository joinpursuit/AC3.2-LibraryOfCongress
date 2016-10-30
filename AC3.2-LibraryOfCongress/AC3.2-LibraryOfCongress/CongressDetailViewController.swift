//
//  ViewController.swift
//  AC3.2-LibraryOfCongress
//
//  Created by Madushani Lekam Wasam Liyanage on 10/29/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class CongressDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var congressImage: UIImageView!

    @IBOutlet weak var detailLabel: UILabel!
    
    var congressLibrary: CongressLibrary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailScrollView.delegate = self
        if let fullImageString = congressLibrary?.fullImageSrting {
        congressImage.downloadImage(urlString: fullImageString)
        }
        
        var subjectsString = ""
        for aSubject in (congressLibrary?.subjectList)! {
            subjectsString += aSubject + "\n"
        }
        detailLabel.text = (congressLibrary?.title)! + "\n\nSubjects: \n\n" + subjectsString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

