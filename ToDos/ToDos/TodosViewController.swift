//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {
    
    @IBOutlet var nothingTodoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - DataSource

extension TodosViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Task"
        nothingTodoLabel.isHidden = true
        return cell
    }

    
}
