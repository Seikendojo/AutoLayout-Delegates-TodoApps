//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {


    // 1. create a class called PersistenceManager
    // 2. initialize the manager at the time the app launches
    // 3. define a method to retrieve all Todo objects
    // 4. define a method to save a new Todo object
    // 5. set myData with the result of the retrieval function
 
    private var myData: [Todo] = {
        var todos = [Todo]()
        if let retrievedTodos = UserDefaults.standard.value(forKey: "todos") as? [String: Any] {
            retrievedTodos.values.forEach { todoDict in
                if let todo = Todo.parse(from: todoDict as! [String : Any]) {
                    todos.append(todo)
                }
            }
        }
        return todos.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
    }()

    //    var persistenceManager: PersistenceManager?
    @IBOutlet var nothingTodoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        

//        myData = persistenceManager.retrieveTodos
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nothingTodoLabel.isHidden = !myData.isEmpty
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showTodoEntry", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showTodoEntry" {
            let navController = segue.destination as? UINavigationController
            let todoEntryVC = navController?.viewControllers.first as? TodoEntryViewController
            todoEntryVC?.delegate = self
        }
    }
}

// MARK: - DataSource
extension TodosViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        let todo = myData[indexPath.row]
        cell.updateCell(with: todo)
        return cell
    }
    
    //Trailing action to delete todo
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoToDelete = myData[indexPath.row]
            myData.remove(at: indexPath.row)

            var todosDict = UserDefaults.standard.value(forKey: "todos") as? [String: Any]
            todosDict?.removeValue(forKey: todoToDelete.id)
            UserDefaults.standard.set(todosDict, forKey: "todos")

            tableView.deleteRows(at: [indexPath], with: .fade)
            reloadData()
        }
    }

    //Leading action to strikethrough the todo text
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [weak self] (action, sourceView, completionHandler) in
            guard let self = self else { return }
            //Replace the old todo with a new version of it
            var newTodo = self.myData[indexPath.row]
            newTodo.isCompleted = true
            
            //Grab the cell from tableViewCell
            let cell = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
            
            //Get the title and cross it out
            cell.updateCell(with: newTodo)

            // step 0
            // retrieve `todos` from UserDefaults
            var todosDict = UserDefaults.standard.value(forKey: "todos") as? [String: Any] ?? [String: Any]()

            // step 1
            // find the matching dictionary in UserDefaults
            var todoDict = todosDict[newTodo.id] as? [String: Any]

            // step 2
            // set the `isCompleted` value for the dictionary
            todoDict?["isCompleted"] = newTodo.isCompleted

            // step 3
            // save the `todos` array back into UserDefaults
            todosDict[newTodo.id] = todoDict
            UserDefaults.standard.set(todosDict, forKey: "todos")

            completionHandler(true)
        }
        
        doneAction.backgroundColor = UIColor.todoGreen
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}

//MARK: Compfort Delegate
extension TodosViewController: AddInputDelegate {
    func addData(data: Todo) {
        myData.append(data)
        myData = myData.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        reloadData()
    }

    private func reloadData() {
        nothingTodoLabel.isHidden = !myData.isEmpty
        tableView.reloadData()
    }
}
