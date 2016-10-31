//
//  LOCViewController.swift
//  LibraryOfCongress
//
//  Created by Annie Tung on 10/29/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class LOCViewController: UIViewController {
    
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var VCImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    var loc: LibraryOfCongress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getAPIPoint(apiEndPoint: loc.imageURL) { (data: Data?) in
            DispatchQueue.main.async {
                if let d = data {
                    self.VCImage.image = UIImage(data: d)
                }
            }
        }
        if let lib = loc {
            self.titleLabel.text = lib.title
            self.creator.text = lib.creator
            self.publishDate.text = String("Published \(lib.publishDate)")
        } else { return }
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
