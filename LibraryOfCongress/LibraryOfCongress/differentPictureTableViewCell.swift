//
//  differentPictureTableViewCell.swift
//  LibraryOfCongress
//
//  Created by Marcel Chaucer on 10/29/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class differentPictureTableViewCell: UITableViewCell {
   
    @IBOutlet weak var pictureTitleText: UILabel!
    @IBOutlet weak var imagePreview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
