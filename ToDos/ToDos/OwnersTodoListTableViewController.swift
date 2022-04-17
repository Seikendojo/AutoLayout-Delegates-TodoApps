//
//  OwnersTodoListTableViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-04-11.
//

import Foundation
import UIKit

class OwnersTodoListTableViewController: UITableViewController {
    
    private let persistanceManager = PersistenceManager()
    
    private var myData: [Todo] {
        persistanceManager.todos.sortedByDate
    }
    
    var personDataDict: [String: [Todo]] {
        persistanceManager.todosDict
    }
    
    @IBOutlet weak var addTodosToPersonBarBtnItem: UIBarButtonItem!
    @IBOutlet weak var nothingTodoLabel: UILabel!
    
    private let imageView = UIImageView(image: UIImage(named: "Bruce"))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nothingTodoLabel.isHidden = !myData.isEmpty
        showImag(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImag(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setupUI()
    }

    private func showImag(_ show: Bool){
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = show ? 1.0 : 0.0
        }
    }
    
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 45
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true

        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
    @IBAction func addTodoToPersonBarBtnTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToTodoEntry", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "goToTodoEntry" {
            let navController = segue.destination as! UINavigationController
            let todoEntryFormVC = navController.viewControllers.first as! TodoEntryViewController
            todoEntryFormVC.delegate = self
            guard let indexPath = sender as? IndexPath else { return }
            let section = Section(rawValue: indexPath.section)!
            todoEntryFormVC.todoToEdit = personDataDict[section.title]?[indexPath.row]
        }
    }
    
    //MARK: - Table view data source methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        personDataDict.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todoSection = Section(rawValue: section)
        return personDataDict[todoSection!.title]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoSection = Section(rawValue: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: "personTodoListCell", for: indexPath) as! OwnersTodoListCell
        let todo = personDataDict[todoSection!.title]?[indexPath.row]
        cell.updatePersonCell(with: todo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let todoSection = Section(rawValue: section)!
        let sectionIsEmpty = personDataDict[todoSection.title]?.isEmpty ?? false
        return sectionIsEmpty ? .none : todoSection.title
    }
    
    //MARK: Trainling action to delete Todo
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let todoSection = Section(rawValue: indexPath.section),
                  let todoToDelete = personDataDict[todoSection.title]?[indexPath.row] else { return }
            persistanceManager.delete(todoToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            reloadData()
        }
    }
     
    //MARK: Leading actions, Done and Undo
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              let todoSection = Section(rawValue: indexPath.section)!
              guard var todoToUpdate = personDataDict[todoSection.title]?[indexPath.row] else { return .none }
        let title = todoToUpdate.isCompleted ? "Undo" : "Done"
        let backgroundColor = todoToUpdate.isCompleted ? UIColor.todoYellow : UIColor.todoGreen
        
        let doneAction = UIContextualAction(style: .normal, title: title) { [weak self] (action, view, completionHandler) in
            todoToUpdate.isCompleted.toggle()
            let cell = tableView.cellForRow(at: indexPath) as! OwnersTodoListCell
            cell.updatePersonCell(with: todoToUpdate)
            self?.persistanceManager.save(todo: todoToUpdate)
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.performSegue(withIdentifier: "goToTodoEntry", sender: nil)
            completionHandler(true)
        }
        doneAction.backgroundColor = backgroundColor
        editAction.backgroundColor = .todoBlue
        return UISwipeActionsConfiguration(actions: [doneAction,editAction])
    }
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension OwnersTodoListTableViewController: TodoInputDelegate {
    func add(todo: Todo) {
        persistanceManager.save(todo: todo)
        reloadData()
    }
    
    func edit(todo: Todo) {
        persistanceManager.save(todo: todo)
        reloadData()
    }
    
    func reloadData() {
        nothingTodoLabel.isEnabled = !myData.isEmpty
        tableView.reloadData()
    }
}
