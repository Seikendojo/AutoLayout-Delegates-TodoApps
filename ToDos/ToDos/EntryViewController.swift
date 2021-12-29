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
    
    
    //MARK: Configure TextField

    func configDateTextField() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        dateTextFeild.text = formatter.string(from: date)
        dateTextFeild.textColor = .blue
    }
    
    //MARK: Configure date picker
    
    func configDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 50)
        dateTextFeild.inputView = datePicker
        
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        dateTextFeild.text = formatter.string(from: sender.date)
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
