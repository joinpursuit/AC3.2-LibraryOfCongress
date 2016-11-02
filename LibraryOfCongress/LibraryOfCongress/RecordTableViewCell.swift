//
//  RecordTableViewCell.swift
//  LibraryOfCongress
//
//  Created by Amber Spadafora on 11/1/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var squarePhoto: UIImageView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(congressRecord: CongressRecord){
        
        indexLabel.text = String(congressRecord.index)
        print("this is the current index \(congressRecord.index)")
        

      
        
        congressRecord.downloadImage(urlString: congressRecord.images.square) { (data: Data) in
            DispatchQueue.main.async {
                self.squarePhoto.image = UIImage(data: data)
                self.setNeedsLayout()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
