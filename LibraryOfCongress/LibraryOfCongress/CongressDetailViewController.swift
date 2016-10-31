//
//  CongressDetailViewController.swift
//  LibraryOfCongress
//
//  Created by Marcel Chaucer on 10/29/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class CongressDetailViewController: UIViewController {
    var detailPicture: MarkTwain?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullPicture: UIImageView!
    @IBOutlet weak var subjectLine: UITextView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = detailPicture {
            self.titleLabel.text = detail.title
            self.subjectLine.text = detail.subjectList.joined(separator: "\n")
            
            let fullURL = "http:" + detail.fullImage
            let url = URL(string: fullURL)
            let data = try? Data(contentsOf: url!)
            if data == nil {
                fullPicture.image = #imageLiteral(resourceName: "placeholder")} else {
                fullPicture.image = UIImage(data: data!)
            }
            
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
