//
//  LOCTableViewController.swift
//  LibraryOfCongress
//
//  Created by Harichandan Singh on 10/27/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class LOCTableViewController: UITableViewController {
    //MARK: - Properties
    internal var results: [Results] = []
    
    //MARK:- Outlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadResults()
    }
    
    //MARK: - Methods
    func loadResults() {
        APIRequestManager.manager.getData(apiEndpoint: APIRequestManager.manager.apiEndpoint) { (data: Data?) in
            if data != nil {
                if let results = Results.turnDataIntoResults(from: data!) {
                    self.results = results
                }
            }
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
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        cell.textLabel?.text = result.title
        
        APIRequestManager.manager.getData(apiEndpoint: result.thumbnailImageString, callback: { (data: Data?) in
            if let d = data {
                cell.imageView?.image = UIImage(data: d)
            }
            DispatchQueue.main.async {
                cell.setNeedsLayout()
            }
        })
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            var indexPath = self.tableView.indexPath(for: cell)
            let result = results[indexPath!.row]
            
            if segue.identifier == "resultSegue" {
                if let dvc = segue.destination as? DetailViewController {
                    dvc.fullTitleString = result.title
                    dvc.imageURLString = result.thumbnailImageString
                    dvc.subjects = result.subjects
                }
            }
        }
    }
    
}
