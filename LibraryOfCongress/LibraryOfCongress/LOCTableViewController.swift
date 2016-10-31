//
//  LOCTableViewController.swift
//  LibraryOfCongress
//
//  Created by Annie Tung on 10/29/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class LOCTableViewController: UITableViewController {
    
    var arrayOfLOC = [LibraryOfCongress]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getAPIPoint(apiEndPoint: "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"){ (data: Data?) in
            if let library = self.validLOC(from: data!) {
                self.arrayOfLOC = library
                print("*****library has been populated")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func validLOC(from jsonData: Data) -> [LibraryOfCongress]? {
        var loc = [LibraryOfCongress]()
        
        do {
            let locData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let locCasted: [String:Any] = locData as? [String:Any] else {
                print("*****THERE WAS AN ERROR CASTING TO [String:Any] \(locData)")
                return nil }
            print("*****GIPHY DATA CREATED \(locData)")
            
            guard let arrOfLOC: [[String:Any]] = locCasted["results"] as? [[String:Any]] else {
                print("*****THERE WAS AN ERROR CASTING TO ANY FROM [String:Any] \(locCasted)")
                return nil }
            print("*****GIPHY INFO WAS CREATED \(arrOfLOC)")
            
            arrOfLOC.forEach({ locObject in
                guard let title: String = locObject["title"] as? String,
                let imageURL: [String:Any] = locObject["image"] as? [String:Any],
                    let fullImage: String = imageURL["full"] as? String,
                    let creator: String = locObject["creator"] as? String,
                    let publishDate: String = locObject["created_published_date"] as? String else { return }
                print("*****imageURL: \(fullImage)")
                print("*****title: \(title)")
                print("*****creator: \(creator)")
                print("*****publishData: \(publishDate)")
                
                let fullImageURL = "https:" + fullImage
                
                loc.append(LibraryOfCongress(title: title, creator: creator, publishDate: publishDate, imageURL: fullImageURL))
            })
            return loc
            }
        catch {
        print("*****ERROR ENCOUNTERED \(error)")
    }
            return nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfLOC.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = arrayOfLOC[indexPath.row].creator
        cell.detailTextLabel?.text = arrayOfLOC[indexPath.row].publishDate
        
        cell.imageView?.image = nil
        
        APIRequestManager.manager.getAPIPoint(apiEndPoint: arrayOfLOC[indexPath.row].imageURL) { (data: Data?) in
            DispatchQueue.main.async {
                if let d = data {
                    cell.imageView?.image = UIImage(data: d)
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locSegue" {
            if let destination = segue.destination as? LOCViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                destination.loc = arrayOfLOC[indexPath.row]
            }
        }
    }
    

}
