//
//  CongressTableViewController.swift
//  AC3.2-LibraryOfCongress
//
//  Created by Madushani Lekam Wasam Liyanage on 10/29/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class CongressTableViewController: UITableViewController {

    
    internal let CongressTableViewCellIdentifier: String = "CongressCellIdentifier"
    internal var congressLibrary: [CongressLibrary] = []
    internal let congressEndpoint: String = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    var selectedCongressLibrary: CongressLibrary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("count \(congressLibrary.count)")

        CongressFactory.makeCongressLibrary(apiEndpoint: congressEndpoint) { (returnedCongressLibrary: [CongressLibrary]?) in
            if let unwrappedReturnedCongressLibrary = returnedCongressLibrary {
                self.congressLibrary = unwrappedReturnedCongressLibrary
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return congressLibrary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CongressCellIdentifier", for: indexPath)

        cell.textLabel?.text = congressLibrary[indexPath.row].creator
        let thumbString = congressLibrary[indexPath.row].thumbImageString
        cell.imageView?.downloadImage(urlString: thumbString)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCongressLibrary = self.congressLibrary[indexPath.row]
        performSegue(withIdentifier: "CongressSegueIdentifier", sender: selectedCongressLibrary)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CongressSegueIdentifier" {
            if let cdvc = segue.destination as? CongressDetailViewController {
                cdvc.congressLibrary = selectedCongressLibrary
            }
            
        }

    }
 

}
