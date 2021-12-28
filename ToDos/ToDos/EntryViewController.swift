//
//  EntryViewController.swift
//  ToDos
//
//  Created by Sia on 2021-12-18.
//

import UIKit

protocol AddInputDelegate {
    func addData(data: InputData)
}


class EntryViewController: UIViewController {
    
    //Create delgate object
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
        saveInputs()
        save()

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
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateTextFeild.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func configureSegment(_ sender: UISegmentedControl) {
        let selectedIndex = priorityControl.isSelected
        if !selectedIndex {
            priorityControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)

            let selectedIndex = priorityControl.selectedSegmentIndex
            switch selectedIndex {
            case 0: print("!")
            case 1: print("!!")
            case 2: print("!!!")
            default:
                break
            }
        }
    }

    
    func saveInputs() {
        let todo = UserDefaults.standard.string(forKey: "todo")
        let date = UserDefaults.standard.string(forKey: "date")
        whatToDoTextFeild.text = todo
        dateTextFeild.text = date
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let todo = whatToDoTextFeild.text
        let date = dateTextFeild.text
        UserDefaults.standard.set(todo, forKey: "todo")
        UserDefaults.standard.set(date, forKey: "date")
        
        guard let todoTask = whatToDoTextFeild.text, !todoTask.isEmpty else {  return }
        guard let date = dateTextFeild.text, !date.isEmpty else { return }
        
        let data = InputData(todoTask: todoTask, date: date)
        delegate?.addData(data: data)
        
        //Check if you can get the input data
        print(data.todoTask)
        print(data.date)
        dismiss(animated: true)
    }

    
    func save() {
        let todoValue = UserDefaults.standard.string(forKey: "todoTask")
        let dateValue = UserDefaults.standard.string(forKey: "date")
        
        if let todoValue = todoValue {
            whatToDoTextFeild.text = todoValue
        } else { whatToDoTextFeild.text = "Enter new task"}
        
        if let dateValue = dateValue {
            dateTextFeild.text = dateValue
        } else { dateTextFeild.text =  "Pick a date"}
    }
    
        
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let todoTask = whatToDoTextFeild.text
        let date = dateTextFeild.text
        UserDefaults.standard.set(todoTask, forKey: "todoTask")
        UserDefaults.standard.set(date, forKey: "date")
        
        guard let todoTask = whatToDoTextFeild.text, !todoTask.isEmpty else {  return }
        guard let date = dateTextFeild.text, !date.isEmpty else { return }
        
        let data = InputData(todoTask: todoTask, date: date)
        delegate?.addData(data: data)
        
        //Check if you can get the input data
        print(data.todoTask)
        print(data.date)
        dismiss(animated: true)
        
    }
    
}
