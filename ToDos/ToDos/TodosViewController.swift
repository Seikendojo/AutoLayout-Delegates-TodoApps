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
        if let retrievedTodos = UserDefaults.standard.value(forKey: "todos") as? [[String: Any]] {
            retrievedTodos.forEach { todoDict in
                if let todo = Todo.parse(from: todoDict) {
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
