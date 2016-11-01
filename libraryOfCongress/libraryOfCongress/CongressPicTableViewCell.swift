//
//  CongressPicTableViewCell.swift
//  libraryOfCongress
//
//  Created by Erica Y Stevens on 10/31/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class CongressPicTableViewCell: UITableViewCell {

    @IBOutlet weak var congressPicTitleLabel: UILabel!
    
    @IBOutlet weak var congressPicImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.congressPicTitleLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//Source: https://www.youtube.com/watch?v=XFvs6eraBXM
extension UIImageView {
    
    func loadImageUsing(url: URL) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            
            if error != nil {
                print("**************")
                print("Error: \(error!)")
               
            }
            
            if let validData = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: validData)
                }
            }  else {
                print("loadImageUsing(url:) -> Method Unsuccessful")
            }
            }.resume()
    }
}
