//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {

    private let persistenceManager = PersistencManager()
    private var myData: [TodoItems] {
        persistenceManager.retrieveTodos().sortedByDate
    }

    @IBOutlet var nothingTodoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
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
            persistenceManager.delete(todoToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    //Leading action to strikethrough the todo text
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoToUpdate = myData[indexPath.row]
        let title = todoToUpdate.isCompleted ? "Undo" : "Done"
        let backgroundColor = todoToUpdate.isCompleted ? UIColor.todoYellow : UIColor.todoGreen

        let doneAction = UIContextualAction(style: .normal, title: title) { [weak self] (action, sourceView, completionHandler) in
            todoToUpdate.isCompleted.toggle()
            let cell = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
            cell.updateCell(with: todoToUpdate)
            let title = todoToUpdate.title
            let date = todoToUpdate.date
            let priority = todoToUpdate.priority
            self?.persistenceManager.save(title: title! , date: date!, priority: priority)
            completionHandler(true)
        }
        doneAction.backgroundColor = backgroundColor
        return UISwipeActionsConfiguration(actions: [doneAction])
    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: Compfort Delegate
extension TodosViewController: AddInputDelegate {
    func addData(data: TodoItems) {
        let data = TodoItems(context: persistenceManager.persistentContainer.viewContext)
        guard let title = data.title,
              let date = data.date else { return }
        let priority = data.priority
        persistenceManager.save(title: title, date: date, priority: priority)
        reloadData()
    }

    private func reloadData() {
        nothingTodoLabel.isHidden = !myData.isEmpty
        tableView.reloadData()
    }
}
