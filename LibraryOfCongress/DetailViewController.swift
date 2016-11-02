//
//  DetailViewController.swift
//  LibraryOfCongress
//
//  Created by Amber Spadafora on 11/1/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var fullSizeImage: UIImageView!
    var record: CongressRecord?
    
    @IBOutlet weak var Subject: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let rec = record {
            print(rec.index)
            
            rec.downloadImage(urlString: rec.images.fullSize) { (data: Data) in
                DispatchQueue.main.async {
                    self.fullSizeImage.image = UIImage(data: data)
                }
            }
            
           
            
            
            Subject.text = rec.title
            
        }
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
