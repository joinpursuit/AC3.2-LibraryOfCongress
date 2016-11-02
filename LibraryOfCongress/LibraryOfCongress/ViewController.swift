//
//  ViewController.swift
//  LibraryOfCongress
//
//  Created by Amber Spadafora on 10/31/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var records: [CongressRecord] = []
    let myCellIdentifyer = "CongressPhotoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        LibraryOfCongressAPI.manager.getData(from: LibraryOfCongressAPI.manager.apiEndPoint){(data: Data?) in
            
            guard let unwrappedData = data else { return }
            
            self.records = CongressRecord.createAnArrayOfRecords(from: unwrappedData)!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//MARK: TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RecordTableViewCell {
        
        let cell: RecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: myCellIdentifyer, for: indexPath) as! RecordTableViewCell
        
        let currentRecord = records[indexPath.row]
        
        cell.setData(congressRecord: currentRecord)
        
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedRecordCell: RecordTableViewCell = sender as? RecordTableViewCell {
            if segue.identifier == "goToDetailsPage" {
                let destination: DetailViewController = segue.destination as! DetailViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedRecordCell)!
                
                //DetailViewController.episode = episodes[cellIndexPath.row]
                let selectedRecord: CongressRecord = records[cellIndexPath.row]
                destination.record = selectedRecord
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//    
    
    
//MARK: Helper Functions
    

    
}
