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
    
    let datePicker = UIDatePicker()
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whatToDoTextFeild.becomeFirstResponder()
        configDatePicker()
        save()
        stylePriorityControl()
    }

    private func stylePriorityControl() {
        priorityControl.selectedSegmentTintColor = .todoBlue
        priorityControl.tintColor = .todoLightBlue
        priorityControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        priorityControl.setTitleTextAttributes([.foregroundColor: UIColor.todoBlue], for: .normal)
    }

    func configToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    func configDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateTextFeild.inputView = datePicker
        dateTextFeild.inputAccessoryView = configToolbar()
        dateTextFeild.textAlignment = .center
    }
    
    @objc func donePressed() {
        dateTextFeild.text = datePicker.date.shortDateString
        self.view.endEditing(true)
    }
    
    @IBAction func configureSegment(_ sender: UISegmentedControl) {
        let selectedIndex = priorityControl.isSelected

        if !selectedIndex {
            priorityControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let todoTask = whatToDoTextFeild.text, !todoTask.isEmpty else {  return }
        guard let date = dateTextFeild.text, !date.isEmpty else { return }

        let data = Todo(title: todoTask, date: datePicker.date, priority: Priority(rawValue: priorityControl.selectedSegmentIndex)!)
        UserDefaults.standard.set(data, forKey: data.id.uuidString)
        delegate?.addData(data: data)
    }

    func save() {
        guard let todoTask = whatToDoTextFeild.text, !todoTask.isEmpty else {  return }
        guard let date = dateTextFeild.text, !date.isEmpty else { return }

        let data = Todo(title: todoTask, date: datePicker.date, priority: Priority(rawValue: priorityControl.selectedSegmentIndex)!)
        UserDefaults.standard.string(forKey: data.id.uuidString)
    }
}
