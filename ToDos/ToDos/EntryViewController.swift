//
//  EntryViewController.swift
//  ToDos
//
//  Created by Sia on 2021-12-18.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var whatToDoTextFeild: UITextField!
    @IBOutlet var dateTextFeild: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whatToDoTextFeild.becomeFirstResponder()
        configDatePicker()
    }
    
    func configToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
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
        }
    }
}
