//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

class TodosViewController: UITableViewController {
    
    //Making data array
    var myData = [Todo]()
    
    @IBOutlet var nothingTodoLabel: UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        myData = makeMockTodos()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nothingTodoLabel.isHidden = !myData.isEmpty
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let VC = EntryViewController()
        VC.delegate = self
    }

    private func makeMockTodos() -> [Todo] {
        let todo1 = Todo(title: "Pick up groceries", date: Date().dayAfter, priority: .low)
        let todo2 = Todo(title: "Buy Xmas tree", date: Date().dayAfter.dayAfter, priority: .medium)
        let todo3 = Todo(title: "Send Xmas gifts", date: Date().dayAfter.dayAfter.dayAfter, priority: .high)
        return [todo1, todo2, todo3]
    }
}


// MARK: - DataSource

extension TodosViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        //Occupy cells at indexpath
        let todo = myData[indexPath.row]
        cell.updateCell(with: todo)

        return cell
    }
}

//MARK: Compfort Delegate

extension TodosViewController: AddInputDelegate {
    func addData(data: Todo) {
        self.dismiss(animated: true) {
            self.myData.append(data)
            self.tableView.reloadData()
        }
    }
}
