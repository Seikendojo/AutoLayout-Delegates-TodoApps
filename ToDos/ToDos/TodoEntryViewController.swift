//
//  TodoEntryViewController.swift
//  ToDos
//
//  Created by Sia on 2021-12-18.
//

import UIKit

protocol AddInputDelegate {
    func addData(data: Todo)
}

class TodoEntryViewController: UIViewController {

    var delegate: AddInputDelegate?
//    var persistenceManager: PersistenceManager?

    @IBOutlet var whatToDoTextFeild: UITextField!
    @IBOutlet var dateTextFeild: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    @IBOutlet var saveBarButton: UIBarButtonItem!

    private var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        configDateTextField()
        stylePriorityControl()
        configTapGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whatToDoTextFeild.becomeFirstResponder()
    }

    private func configTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap() {
        view.endEditing(true)
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
            datePicker = datePickerView
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
        // persistenceManager.save(todo)
        delegate?.addData(data: todo)
        dismiss(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
