//
//  DetailViewController.swift
//  LiBrArY oF CONgress
//
//  Created by C4Q on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageString: String?
    var titleText: String?
    var subject: String?

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        subjectLabel.text = subject
        
        APIManager.manager.getData(endPoint: imageString!) { (data: Data?) in
            if let d = data {
                self.picture.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                print("finally finish")
                self.view.reloadInputViews()
                
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
 

}
