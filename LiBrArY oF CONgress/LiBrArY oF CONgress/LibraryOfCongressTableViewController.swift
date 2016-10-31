//
//  LibraryOfCongressTableViewController.swift
//  LiBrArY oF CONgress
//
//  Created by C4Q on 10/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class LibraryOfCongressTableViewController: UITableViewController {
    
    let endpoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    var pictures: [Stuff]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.manager.getData(endPoint: endpoint) { (data: Data?) in
            if let d = data {
                self.pictures = Stuff.parseData(data: d)
                
                DispatchQueue.main.async {
                    print(self.pictures?.count)
                    self.tableView.reloadData()
                }
                
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return pictures?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryOfCongressCell", for: indexPath)
        let currentPic = pictures![indexPath.row]
        
        cell.imageView?.image = #imageLiteral(resourceName: "default-placeholder")
        APIManager.manager.getData(endPoint: currentPic.imageThumb) { (data: Data?) in
            if let d = data {
                cell.imageView?.image = UIImage(data: d)
                DispatchQueue.main.async {
                    cell.reloadInputViews()
                }
            }
        }
        cell.textLabel?.text = currentPic.title
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegueID" {
            let dvc = segue.destination as! DetailViewController
            let cellIndex = self.tableView.indexPath(for: sender as! UITableViewCell)!
            
            dvc.titleText = self.pictures![cellIndex.row].title
            dvc.imageString = self.pictures![cellIndex.row].imageFull
            dvc.subject = self.pictures![cellIndex.row].subjectList
            
        }
    }
    
}
