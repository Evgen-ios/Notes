//
//  TableViewController.swift
//  Notes
//
//  Created by Evgeniy Goncharov on 06.03.2021.
//

import UIKit
import RealmSwift


class TableViewController: UITableViewController {
    var items = realm.objects(NoteItems.self)
    
    @IBAction func editAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFirstItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.titleNote
        cell.detailTextLabel?.text = currentItem.dateNote
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        let nvc = segue.destination as! NoteViewController
        if segue.identifier == "updateNote" {
            nvc.noteItemsObject = items[tableView.indexPathForSelectedRow!.row]
            nvc.title = "Редактировать"
            nvc.segue = true
        } else {
            nvc.segue = false
            nvc.title = "Новая заметка"
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currentItem = items[indexPath.row]
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: currentItem)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
}
