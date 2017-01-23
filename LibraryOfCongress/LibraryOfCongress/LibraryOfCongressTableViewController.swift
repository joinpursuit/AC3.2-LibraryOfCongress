//
//  LibraryOfCongressTableViewController.swift
//  LibraryOfCongress
//
//  Created by Ana Ma on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class LibraryOfCongressTableViewController: UITableViewController {
    
    var prints = [Print]()
    var endpoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    //Library of Congress Prints & Photographs
    //
    //And now for something completely different...
    //    Object: Build another table with thumbs linking to a full view.
    //
    //Endpoint:
    //
    //https://loc.gov/pictures/search/?q=mark%20twain&fo=json
    //Title and thumb in table view.
    //
    //Full image, title, and subject list on the detail page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APImanager.manager.getData(endpoint: endpoint) { (data: Data?) in
            if data != nil {
                self.prints = Print.getData(from: data!)!
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prints.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryOfCongressCell", for: indexPath)
        //use of closure with the image extension of and it will fix the bug
        DispatchQueue.main.async {
            cell.textLabel?.text = self.prints[indexPath.row].title
            cell.detailTextLabel?.text = " "
            cell.imageView?.downloadImage(urlString: self.prints[indexPath.row].thumbURLString)
            cell.setNeedsLayout()
        }
        
        
        
//        APImanager.manager.getData(endpoint: print[indexPath.row].thumbURLString) { (data: Data?) in
//            DispatchQueue.main.async {
//                if let validData = data {
//                    cell.imageView?.image = UIImage(data: validData)
//                    cell.setNeedsLayout()
//                }
//            }
//        }
        
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedPrint = self.print[indexPath.row]
//        performSegue(withIdentifier: "libraryOfCongressDetailViewSegue", sender: selectedPrint)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "libraryOfCongressDetailViewSegue" {
            if let detailLibraryOfCongressViewController = segue.destination as? DetailLibraryOfCongressViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                let selectedPrint = self.prints[indexPath.row]
                //let selectedPrint = sender as? Print
                detailLibraryOfCongressViewController.onePrint = selectedPrint
            }
        }
    }
}
