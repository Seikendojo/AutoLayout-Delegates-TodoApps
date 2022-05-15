//
//  OwnersTableViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-10.
//

import Foundation
import UIKit

class OwnersTableViewController: UITableViewController {
    private var persistenceManager = PersistenceManager()
    private var selectedIndexPath = IndexPath()
    private lazy var people: [Person] = persistenceManager.people.sortedLastName

    @IBOutlet weak var noOneTodoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    @IBAction func addNewOwner(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toPersonEntry", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPersonEntry" {
            let navController = segue.destination as? UINavigationController
            let ownerEntryVC = navController?.viewControllers.first as? OwnerEntryFormViewController
            ownerEntryVC?.delegate = self
        }

        if segue.identifier == "toTodosList" {
            let destinationVC = segue.destination as? TodosViewController
            destinationVC?.hidesBottomBarWhenPushed = true
            let owner = people[selectedIndexPath.row]
            destinationVC?.style = .individual(owner: owner)
        }
    }
}

extension OwnersTableViewController: PersonInputDelegate {
    func add(new person: Person) {
        persistenceManager.save(person: person)
        reloadData()
    }
}

extension OwnersTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! OwnersTableViewCell
        let person = people[indexPath.row]
        cell.update(with: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toTodosList", sender: self)
    }
    
    private func reloadData() {
        people = persistenceManager.people.sortedLastName
        noOneTodoLabel.isHidden = !people.isEmpty
        tableView.reloadData()
    }
}
