//
//  OwnersTableViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-10.
//

import Foundation
import UIKit


class OwnersTableViewController: UITableViewController {
    private var persistenceManager = PersistencManager()
    
    private var people: [Person] {
        persistenceManager.people.sortedLastName
    }

    @IBOutlet weak var noOneTodoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
 
    
    @IBAction func addOwnerBarButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToOwnerEntry", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "goToOwnerEntry" {
            let navCOntroller = segue.destination as? UINavigationController
            let ownerEntryVC = navCOntroller?.viewControllers.first as? OwnerEntryFormViewController
            ownerEntryVC?.ownerDelegate = self
        }
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
        cell.updateOwnerCell(with: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToOwnerTodoList", sender: self)
    }
    
    private func reloadData() {
        noOneTodoLabel.isHidden = !people.isEmpty
        tableView.reloadData()
    }
}

extension OwnersTableViewController: AddOwnerDelegate {
    func add(person: Person) {
        persistenceManager.people.append(person)
        tableView.reloadData()
    }
}
