//
//  ListTableViewController.swift
//  SharedToDoList
//
//  Created by Nikhil Trivedi on 1/4/19.
//  Copyright © 2019 Nikhil Trivedi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
//import ChameleonFramework

class ListTableViewController: UITableViewController {

    @IBOutlet var toDoTableView: UITableView!
    
    var toDoArray = [ToDoObject]()
    //var dbr: DatabaseReference = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.register(UINib(nibName: "ToDoItemCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        toDoTableView.delegate = self
        configureTableView()
        retrieveMessages()
        toDoTableView.separatorStyle = .none
    }

    // MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row].text
        if(toDoArray[indexPath.row].checkmark == true) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // Delete the item
            let messagesDB = Database.database().reference().child("ToDos")
            toDoArray.remove(at: indexPath.row)
    //        messagesDB.child("-LVeiJY5qN2mhq6UjEMN").removeValue()
        } else {
            toDoArray[indexPath.row].checkmark = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let messagesDB = Database.database().reference().child("ToDos")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Go", style: .default) { (action) in
            let toDoDictionary = ["Sender": Auth.auth().currentUser?.email, "ToDo": textField.text!]
            messagesDB.childByAutoId().setValue(toDoDictionary) {
                (error, reference) in
                if error != nil {
                    print(error!)
                }
                print("reference")
            }
            
            self.tableView.reloadData()
        }
        
       // dbr = reference
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func configureTableView() {
        toDoTableView.rowHeight = UITableViewAutomaticDimension
        toDoTableView.estimatedRowHeight = 120.0
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("ToDos")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let toDoObj = ToDoObject()
            toDoObj.person = snapshotValue["Sender"]!
            toDoObj.text = snapshotValue["ToDo"]!
            toDoObj.checkmark = false
            self.toDoArray.append(toDoObj)
            self.configureTableView()
            self.toDoTableView.reloadData()
        }
        
    }

    
}
