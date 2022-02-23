//
//  TodoEntryViewController.swift
//  ToDos
//
//  Created by Sia on 2021-12-18.
//

import UIKit

protocol AddInputDelegate {
    func add(todo: Todo)
    func edit(todo: Todo)
}

class TodoEntryViewController: UIViewController {
   
    var delegate: AddInputDelegate?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var todoToEdit: Todo?

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
        configTodoEdit()
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
    
    func configTodoEdit() {
        if let todo = todoToEdit {
            title = "Edit Item"
            whatToDoTextFeild.text = todo.title
            dateTextFeild.text = todo.date.shortDateString
            priorityControl.selectedSegmentIndex = todo.priority.rawValue
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if var todoToEdit = todoToEdit {
            todoToEdit.title = whatToDoTextFeild.text!
            //todoToEdit.priority.rawValue = priorityControl.selectedSegmentIndex
            todoToEdit.date = datePicker.date
            delegate?.edit(todo: todoToEdit)
            dismiss(animated: true)
           
        } else {
            guard let title = whatToDoTextFeild.text else { return }
            let date = datePicker.date
            let priority = Priority(rawValue: priorityControl.selectedSegmentIndex) ?? .low
            delegate?.add(todo: .init(title: title, date: date, priority: priority))
            dismiss(animated: true)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
        
    }
}
