//
//  PhotoTableViewCell.swift
//  LibraryOfCongress
//
//  Created by Sabrina Ip on 10/30/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoNameLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
