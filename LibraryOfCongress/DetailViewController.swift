//
//  DetailViewController.swift
//  LibraryOfCongress
//
//  Created by Harichandan Singh on 10/30/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var fullTitleString = ""
    var imageURLString = ""
    var subjects = [String]()
    
    //MARK: - Outlets
    @IBOutlet weak var fullTitleLabel: UILabel!
    @IBOutlet weak var twainImageView: UIImageView!
    @IBOutlet weak var subjectTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullTitleLabel.text = fullTitleString
        self.subjectTextView.text = createSubjectString()
        
        APIRequestManager.manager.getData(apiEndpoint: imageURLString, callback: { (data: Data?) in
            if let d = data {
                self.twainImageView.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                self.reloadInputViews()
            }
        })
    }
    
    func createSubjectString() -> String {
        var subjectString = String()
        for string in subjects {
            subjectString += string + "\n"
        }
        return subjectString
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
