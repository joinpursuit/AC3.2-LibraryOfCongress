//
//  CongressTableViewController.swift
//  LibraryOfCongress
//
//  Created by Marcel Chaucer on 10/29/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class CongressTableViewController: UITableViewController {
  
       override func viewDidLoad() {
        super.viewDidLoad()
        PictureFactory.manager.loadData()
        self.title = "Mark Twain"
    
    }

        // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PictureFactory.manager.pictures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "differentPictures", for: indexPath)
        //PictureFactory.manager.pictures[indexPath.row].thumbPic.characters.removeFirst(2)
        let urlString = PictureFactory.manager.pictures[indexPath.row].thumbPic
        let fullString = "http:" + urlString
        let url = URL(string: fullString)
        let data = try? Data(contentsOf: url!)
        
        if let pictureCell: differentPictureTableViewCell = cell as? differentPictureTableViewCell {
            pictureCell.pictureTitleText.text = PictureFactory.manager.pictures[indexPath.row].title
            
            if data == nil {
                pictureCell.imagePreview.image = #imageLiteral(resourceName: "placeholder") } else {
                pictureCell.imagePreview.image = UIImage(data: data!)
            }
            }
         return cell
        }
    

    


// MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destination = segue.destination as? CongressDetailViewController {
                destination.detailPicture =  sender as? MarkTwain
            }
        }
}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPicture = PictureFactory.manager.pictures[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: selectedPicture)
    }
}

