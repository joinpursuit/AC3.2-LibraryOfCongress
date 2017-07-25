//
//  ConLibTableViewController.swift
//  LibraryOfCongress
//
//  Created by Tom Seymour on 10/27/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class ConLibTableViewController: UITableViewController {
    
    var photos: [CongressPhoto] = []
    let myCellIdentifyer = "CongressPhotoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        ConLibAPI.manager.getData(endPoint: ConLibAPI.manager.endPoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.photos = CongressPhoto.returnArrayOfCongressPhotos(from: unwrappedData)!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: myCellIdentifyer, for: indexPath)
        let thisCongressPhoto = photos[indexPath.row]
        cell.textLabel?.text = thisCongressPhoto.title
        ConLibAPI.manager.downloadImage(urlString: thisCongressPhoto.images.square) { (data: Data) in
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data)
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCongressPhoto = photos[indexPath.row]
        performSegue(withIdentifier: "ConPhoDetailSegue", sender: selectedCongressPhoto)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConPhoDetailSegue" {
            if let destinationViewController = segue.destination as? ConPhoDetailViewController {
                destinationViewController.thisCongressPhoto = sender as? CongressPhoto
            }
        }
    }

}





