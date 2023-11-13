//
//  CategoryViewController.swift
//  TodoList
//
//  Created by 井本智博 on 2023/11/08.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
    }
    
    //MARK: - Add New Category
    @IBAction func addButttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
           
        }
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Create a category"
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name
        }
        
        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
      
    }
    //MARK: - Manipulation Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToTodoList", sender: self)
        
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error deleting category \(error)")
            }
            tableView.reloadData()
        }
    }
   
}

