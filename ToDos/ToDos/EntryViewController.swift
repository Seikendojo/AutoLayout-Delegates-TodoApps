//
//  EntryViewController.swift
//  ToDos
//
//  Created by Sia on 2021-12-18.
//

import UIKit

protocol AddInputDelegate {
    func addData(data: Todo)
}

class EntryViewController: UIViewController {
    
    var delegate: AddInputDelegate?
    
    @IBOutlet var whatToDoTextFeild: UITextField!
    @IBOutlet var dateTextFeild: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    @IBOutlet var saveBarButton: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDateTextField()
        stylePriorityControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whatToDoTextFeild.becomeFirstResponder()
    }

    private func stylePriorityControl() {
        priorityControl.selectedSegmentTintColor = .todoBlue
        priorityControl.tintColor = .todoLightBlue
        priorityControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        priorityControl.setTitleTextAttributes([.foregroundColor: UIColor.todoBlue], for: .normal)
    }

    //MARK: Configure TextField

    func configDateTextField() {
        dateTextFeild.addDatePicker(target: self, doneAction: #selector(doneAction), cancelAction: #selector(cancelAction))
    }

    @objc
    func cancelAction() {
        dateTextFeild.resignFirstResponder()
    }

    @objc
    func doneAction() {
        if let datePickerView = dateTextFeild.inputView as? UIDatePicker {
            dateTextFeild.text = datePickerView.date.shortDateString
            dateTextFeild.resignFirstResponder()
        }
    }

    @IBAction func configureSegment(_ sender: UISegmentedControl) {
        let selectedIndex = priorityControl.isSelected

        if !selectedIndex {
            priorityControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let todoTask = whatToDoTextFeild.text, !todoTask.isEmpty,
                let priority = Priority(rawValue: priorityControl.selectedSegmentIndex) else { return }

        let todo = Todo(title: todoTask, date: datePicker.date, priority: priority)
        var todos = UserDefaults.standard.value(forKey: "todos") as? [[String: Any]] ?? [[String: Any]]()
        todos.append(todo.dictionary)
        UserDefaults.standard.set(todos, forKey: "todos")
        delegate?.addData(data: todo)
        dismiss(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
