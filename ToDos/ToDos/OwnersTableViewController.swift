//
//  OwnersTableViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-10.
//

import Foundation
import UIKit


class OwnersTableViewController: UITableViewController {
    private let persistenceManager = PersistencManager()
    
    private var people: [Person] {
        persistenceManager.people.sortedLastName
    }

    @IBOutlet weak var noOneTodoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.updateOwnerCell(with: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func reloadData() {
        noOneTodoLabel.isHidden = !people.isEmpty
        tableView.reloadData()
    }
}
