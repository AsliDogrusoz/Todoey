//
//  ViewController.swift
//  Todoey
//
//  Created by Asli Dogrusoz on 11/5/18.
//  Copyright © 2018 Asli Dogrusoz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print(dataFilePath)
        
        
        loadItems()
        
        //         if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //             itemArray = items
        //
        //     }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //if item.done == true {
        //    cell.accessoryType = .checkmark
        //} else {
        //   cell.accessoryType = .none
        // }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //       print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
       // if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //
       // } else {
       //     tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       // }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks the add item button)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    //MARK - Model manipulation methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array \(error)")
            }
        }
    }
    
}

