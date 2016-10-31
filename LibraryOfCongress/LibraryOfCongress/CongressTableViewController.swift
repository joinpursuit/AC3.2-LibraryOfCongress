//
//  ViewController.swift
//  LibraryOfCongress
//
//  Created by Ilmira Estil on 10/30/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class CongressTableViewController: UITableViewController {
    internal var congressLibrary = [Congress]()
    
    let apiEndpoint: String = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadLibrary()
        self.refreshControl?.addTarget(self, action: #selector(refreshRequested(_:)), for: .valueChanged)
    }
    
    func loadLibrary() {
        APIRequestManager.manager.getCongressJdata(endpoint: apiEndpoint) { (data: Data?) in
            if data != nil {
                if let library = Congress.getCongressData(from: data!) {
                    self.congressLibrary = library
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func refreshRequested(_ sender: UIRefreshControl) {
        self.loadLibrary()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return congressLibrary.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "congressCell", for: indexPath)
        let selectedCell = congressLibrary[indexPath.row]
        
        //description
        cell.textLabel?.text = selectedCell.description
        
        //images
        let imageIdentifier = selectedCell.imageThumbURL
        cell.imageView?.downloadImage(urlString: imageIdentifier)
        
        //
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let selectedCell = congressLibrary[indexPath!]
        let vc = segue.destination as! DetailViewController
            vc.fullImage = selectedCell.imageFullURL
        
        }
    }
    
}

