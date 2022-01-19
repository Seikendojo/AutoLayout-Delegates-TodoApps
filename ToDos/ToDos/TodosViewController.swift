//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {

    private let persistenceManager = PersistencManager()
    private var myData = [Todo]()

    @IBOutlet var nothingTodoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        myData = persistenceManager.retrieveTodos().sortedByDate
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
            todoEntryVC?.persistenceManager = persistenceManager
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

            persistenceManager.delete(todoToDelete)

            tableView.deleteRows(at: [indexPath], with: .fade)
            reloadData()
        }
    }

    //Leading action to strikethrough the todo text
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let doneAction = UIContextualAction(style: .normal, title: "Done") { [weak self] (action, sourceView, completionHandler) in
            guard let self = self else { return }
            var todoToUpdate = self.myData[indexPath.row]
            todoToUpdate.isCompleted = true
            let cell = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
            cell.updateCell(with: todoToUpdate)

            self.persistenceManager.save(todoToUpdate)

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
        myData = myData.sortedByDate
        reloadData()
    }

    private func reloadData() {
        nothingTodoLabel.isHidden = !myData.isEmpty
        tableView.reloadData()
    }
}
