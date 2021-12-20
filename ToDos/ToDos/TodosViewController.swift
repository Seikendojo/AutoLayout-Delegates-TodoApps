//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {
    
    @IBOutlet var nothingTodoLabel: UILabel!
    
    let mytodoData = ["Pick up grouceries",
                      "Buy Xmas Tree",
                      "Send Xmas gifts"]
    
    let priorityData = ["!",
                        "!!",
                        "!!!"]
    
    let timeData = ["tomorrow",
                    "Dec 17, 2021",
                    "Dec 18, 2021"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// MARK: - DataSource

extension TodosViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mytodoData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.todoTextLabel?.text = mytodoData[indexPath.row]
        cell.priorityLabel.text = priorityData[indexPath.row]
        cell.timeLabel.text = timeData[indexPath.row]
        nothingTodoLabel.isHidden = true
        
        return cell
    }
}
