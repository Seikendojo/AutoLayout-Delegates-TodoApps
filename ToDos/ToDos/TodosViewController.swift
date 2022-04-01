//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {
    private let persistenceManager = PersistencManager()
    private var myData: [Todo] {
        persistenceManager.todos.sortedByDate
    }

    private var myDataDict: [String: [Todo]] {
        persistenceManager.todosDict
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
            guard let indexPath = sender as? IndexPath else { return }
            let section = Section(rawValue: indexPath.section)!
            todoEntryVC?.todoToEdit = myDataDict[section.title]?[indexPath.row]
        }
    }
}

// MARK: - DataSource
extension TodosViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        myDataDict.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todoSection = Section(rawValue: section)!
        return myDataDict[todoSection.title]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoSection = Section(rawValue: indexPath.section)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        let todo = myDataDict[todoSection.title]?[indexPath.row]
        cell.updateCell(with: todo)
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let todoSection = Section(rawValue: section)!
        let sectionIsEmpty = myDataDict[todoSection.title]?.isEmpty ?? false
        return sectionIsEmpty ? .none : todoSection.title
    }

    //Trailing action to delete todo
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let todoSection = Section(rawValue: indexPath.section),
            let todoToDelete = myDataDict[todoSection.title]?[indexPath.row] else { return }
            persistenceManager.delete(todoToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            reloadData()
        }
    }

    //Leading action to strikethrough the todo text
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoSection = Section(rawValue: indexPath.section)!
        guard var todoToUpdate = myDataDict[todoSection.title]?[indexPath.row] else { return .none }
        let title = todoToUpdate.isCompleted ? "Undo" : "Done"
        let backgroundColor = todoToUpdate.isCompleted ? UIColor.todoYellow : UIColor.todoGreen

        let doneAction = UIContextualAction(style: .normal, title: title) { [weak self] (action, sourceView, completionHandler) in
            todoToUpdate.isCompleted.toggle()
            let cell = tableView.cellForRow(at: indexPath) as! TodoTableViewCell
            cell.updateCell(with: todoToUpdate)
            self?.persistenceManager.save(todo: todoToUpdate)
            completionHandler(true)
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.performSegue(withIdentifier: "showTodoEntry", sender: indexPath)
            completionHandler(true)
        }
        doneAction.backgroundColor = backgroundColor
        editAction.backgroundColor = .todoBlue
        return UISwipeActionsConfiguration(actions: [doneAction, editAction])
    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTodoEntry", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Compfort Delegate
extension TodosViewController: AddInputDelegate {
    
    func edit(todo: Todo) {
        persistenceManager.save(todo: todo)
        reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func add(todo: Todo) {
        persistenceManager.save(todo: todo)
        reloadData()
    }

    private func reloadData() {
        nothingTodoLabel.isHidden = !myData.isEmpty
        tableView.reloadData()
    }
}

enum Section: Int {
    case todo
    case done

    var title: String {
        switch self {
        case .todo: return "To Complete"
        case .done: return "Completed"
        }
    }
}
