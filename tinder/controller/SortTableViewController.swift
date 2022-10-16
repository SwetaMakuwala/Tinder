//
//  SortTableViewController.swift
//  tinder
//
//  Created by sweta makuwala on 19/12/21.
//

import UIKit

class SortTableViewController: UITableViewController {
    
    var name = String()
    var rowToDelet = Int()
  //  var deleteDelegate : deleteDelegate!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.reloadData()
        
  
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableViewController.personArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! SortTableViewCell
        cell.textLabel?.text = TableViewController.personArray[indexPath.row].name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
 
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tableVC = TableViewController()
            tableVC.deleteFavPresonFromcell(person: TableViewController.personArray[indexPath.row])
       
            tableView.reloadData()
        }
    }
}

    
    

