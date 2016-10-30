//
//  LibraryOfCongressTableViewController.swift
//  LibraryOfCongress
//
//  Created by Ana Ma on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class LibraryOfCongressTableViewController: UITableViewController {
    
    var print = [Print]()
    var endpoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    //    Library of Congress Prints & Photographs
    //
    //    And now for something completely different...
    //    Object: Build another table with thumbs linking to a full view.
    //
    //    Endpoint:
    //
    //    https://loc.gov/pictures/search/?q=mark%20twain&fo=json
    //    Title and thumb in table view.
    //
    //    Full image, title, and subject list on the detail page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APImanager.manager.getData(endpoint: endpoint) { (data: Data?) in
            if data != nil {
                self.print = Print.getData(from: data!)!
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
        return print.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryOfCongressCell", for: indexPath)
        cell.textLabel?.text = print[indexPath.row].title
        cell.detailTextLabel?.text = " "
        
        APImanager.manager.getData(endpoint: print[indexPath.row].thumbURLString) { (data: Data?) in
            DispatchQueue.main.async {
                if let validData = data {
                    cell.imageView?.image = UIImage(data: validData)
                    cell.setNeedsLayout()
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPrint = self.print[indexPath.row]
        performSegue(withIdentifier: "libraryOfCongressDetailViewSegue", sender: selectedPrint)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "libraryOfCongressDetailViewSegue" {
         let detailLibraryOfCongressViewController = segue.destination as? DetailLibraryOfCongressViewController
            let selectedPrint = sender as? Print
            detailLibraryOfCongressViewController?.onePrint = selectedPrint
        }
    }
    
}
