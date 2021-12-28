//
//  TodosViewController.swift
//  ToDos
//
//  Created by Shahin on 2021-12-18.
//

import UIKit

struct InputData {
    var todoTask: String
    var date: String
}

class TodosViewController: UITableViewController {
    
    //Making data array
    var myData = [InputData]()
    
    @IBOutlet var nothingTodoLabel: UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let VC = EntryViewController()
        VC.delegate = self
    }
}


// MARK: - DataSource

extension TodosViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //Occupy cells at indexpath
        cell.todoTextLabel?.text = myData[indexPath.row].todoTask
        cell.timeLabel.text = myData[indexPath.row].date
    
        nothingTodoLabel.isHidden = true
    
        return cell
    }
}

//MARK: Compfort Delegate

extension TodosViewController: AddInputDelegate {
    func addData(data: InputData) {
        self.dismiss(animated: true) {
            self.myData.append(data)
            self.tableView.reloadData()
        }
    }
}
