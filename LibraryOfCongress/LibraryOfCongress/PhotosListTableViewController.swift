//
//  PhotosListTableViewController.swift
//  LibraryOfCongress
//
//  Created by Sabrina Ip on 10/30/16.
//  Copyright © 2016 Sabrina Ip. All rights reserved.
//

import UIKit

class PhotosListTableViewController: UITableViewController {

    var photos = [Photographs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequestManager.manager.getData { (data: Data?) in
            if let unwrappedData = Photographs.getPhotoInfo(from: data!) {
                self.photos = unwrappedData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.title = "Library of Congress - Mark Twain"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        let photograph = photos[indexPath.row]
        cell.photoNameLabel.text = photograph.title
        cell.thumbnailImage.downloadImage(urlString: photograph.thumbnailPhoto)
        return cell
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLargePhoto" {
            if let dest = segue.destination as? IndividualPhotoViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                dest.individualPhoto = photos[indexPath.row]
            }
        }
    }

}
