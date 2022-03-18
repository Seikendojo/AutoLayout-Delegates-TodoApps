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

class TodoEntryViewController: UIViewController, UIPopoverPresentationControllerDelegate {
   
    @IBOutlet var personPhotoButton: UIButton!
    
   // var imageName = ""
    
    var delegate: AddInputDelegate?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var todoToEdit: Todo?

    @IBOutlet var whatToDoTextFeild: UITextField!
    @IBOutlet var dateTextFeild: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    @IBOutlet var saveBarButton: UIBarButtonItem!

    private var datePicker = UIDatePicker()

    override func viewDidLoad() {
       // personPhotoButton.imageView?.image = UIImage(named: imageName)
        super.viewDidLoad()
        configPersonButton()
        configDateTextField()
        stylePriorityControl()
        configTapGesture()
        configTodoEdit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whatToDoTextFeild.becomeFirstResponder()
        personPhotoButton.imageView?.contentMode = UIView.ContentMode.scaleToFill
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
    
    func configPersonButton(){
        personPhotoButton.layer.cornerRadius = personPhotoButton.frame.width / 2
        personPhotoButton.layer.borderWidth = 2
        personPhotoButton.layer.masksToBounds = false
        personPhotoButton.layer.borderColor = UIColor.darkGray.cgColor
        personPhotoButton.clipsToBounds = true
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPopup" {
            let destinationVC = segue.destination as? OwnerPopupViewController
            destinationVC?.photoSelectionDelegate = self
            destinationVC?.popoverPresentationController?.backgroundColor = .lightGray
            destinationVC?.popoverPresentationController?.delegate = self
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func personPhotoBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPopup", sender: nil)
    }
}

extension TodoEntryViewController: ownerPhotoSelectionDelegate {
    func didTapChoice(image: UIImage) {
        personPhotoButton.setImage(image, for: .normal)
        personPhotoButton.setTitle("", for: .normal)
    }
}

extension TodoEntryViewController: UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
