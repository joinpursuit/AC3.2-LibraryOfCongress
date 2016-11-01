//
//  LibraryOfCongressTableViewController.swift
//  libraryOfCongress
//
//  Created by Erica Y Stevens on 10/31/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class LibraryOfCongressTableViewController: UITableViewController {
    
    internal let congressAPIEndpoint: String = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
    internal var congressPics = [CongressPic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCongressPicswith(apiEndpoint: congressAPIEndpoint) { (congressPics: [CongressPic]?) in
            if congressPics != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.congressPics = congressPics!
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
        return congressPics.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CongressCell", for: indexPath) as! CongressPicTableViewCell
        
        // Configure the cell...
        let congressPic = congressPics[indexPath.row]
        cell.congressPicTitleLabel.text = congressPic.title
        var thumbnailURLString = congressPic.thumbnailURLString
        thumbnailURLString.insert(contentsOf: "http:".characters, at: thumbnailURLString.startIndex)
        print(thumbnailURLString)
        if let thumbnailURL = URL(string: thumbnailURLString) {
            cell.congressPicImageView.loadImageUsing(url: thumbnailURL)
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! DetailViewController
        if let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell) {
            let congressPic = congressPics[indexPath.row]
            let subjectsArray: [String] = congressPic.subjects
            
            subjectsArray.forEach({ (subject) in
                vc.subjectsListText += "\(subject)\n\n"
            })
            
            vc.congressPicTitleText = congressPic.title
            
            var fullImageString = congressPic.fullImageURLString
            fullImageString.insert(contentsOf: "http:".characters, at: fullImageString.startIndex)
            vc.fullImageURLString = fullImageString
        }
    }
    
    
    // MARK: - API Request
    
    func getCongressPicswith(apiEndpoint: String, callback: @escaping ([CongressPic]?) -> Void) {
        //Try to conver string to url
        if let validAPIEndpoint = URL(string: apiEndpoint) {
            
            //URL session
            let session = URLSession(configuration: URLSessionConfiguration.default)
            //Data Task
            session.dataTask(with: validAPIEndpoint) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                
                //Immediately check for errors
                if error != nil {
                    print("Error encountered: \(error)")
                }
                
                if let validData = data {
                    if let congressPics: [CongressPic] = CongressPicFactory.manager.getCongressPics(from: validData) {
                        print(congressPics)
                        callback(congressPics)
                    }
                }
                
                }.resume()
        } else {
            print("String was unable to be converted into a URL")
        }
    }
}
