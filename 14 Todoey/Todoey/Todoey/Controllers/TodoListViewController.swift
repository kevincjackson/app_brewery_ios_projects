//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Kevin Jackson on 1/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

    var todoItems: Results<Item>?
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Set Database
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = selectedCategory!.name
        let color = HexColor(selectedCategory!.color)!
        updateNavBarColor(with: color)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        updateNavBarColor(with: UIColor(hexString: "1D9BF6")!)

    }
    
    // MARK: - UI Update
    func updateNavBarColor(with color: UIColor) {

        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = color
            navBar.tintColor = FlatWhite()
            navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
            
            searchBar.barTintColor = color
        }
    }

    // MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
            let baseColor = selectedCategory!.color
            let darkenPercentage = CGFloat(indexPath.row) / CGFloat(todoItems!.count);
            let cellColor =  HexColor(baseColor)!.darken(byPercentage: darkenPercentage)!
            cell.backgroundColor = cellColor
            cell.textLabel?.textColor = ContrastColorOf(cellColor, returnFlat: true)
        }
        else {
            cell.textLabel?.text = "No items yet."
            cell.backgroundColor = UIColor.randomFlat
        }
        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    
    // Toggle checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                    
                    // Realm uses a delete method
                    // realm.delete(item)
                }
            }
            catch {
                print("Error updating item: \(error)")
            }
        }

        tableView.reloadData()
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
         
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }

                }
                catch {
                    print("Error saving context: \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

//     Load from database
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        
        if let item = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            }
            catch {
                print("Error deleting item: \(error)")
            }
        }
    }
    
    
}



// MARK: - Search Bar
extension TodoListViewController: UISearchBarDelegate {

    // Filter by predicate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }

    // Check for blank search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text!.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
