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
   
    private struct Constants {
        static let keyboardOffset = CGPoint(x: 0, y: 40)
    }
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    var delegate: AddInputDelegate?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var todoToEdit: Todo?

    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var DueDateView: UIView!
    @IBOutlet weak var whatTodoView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet var whatToDoTextFeild: UITextField!
    @IBOutlet var dateTextFeild: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    @IBOutlet var saveBarButton: UIBarButtonItem!

    private var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        whatToDoTextFeild.delegate = self
        dateTextFeild.delegate = self
        configDateTextField()
        stylePriorityControl()
        configTapGesture()
        setupKeyboardHiding()
        configTodoEdit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ownerImageView.contentMode = .scaleAspectFill
    }

    private func configTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.isEnabled = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func handleTap() {
        view.endEditing(true)
        tapGestureRecognizer.isEnabled = false
        keyboardWillHide()
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

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow() {
        scrollView.setContentOffset(Constants.keyboardOffset, animated: true)
    }

    @objc private func keyboardWillHide() {
        scrollView.setContentOffset(.zero, animated: true)
    }
}

extension TodoEntryViewController: ownerPhotoSelectionDelegate {
    func didTapChoice(image: UIImage) {
        ownerImageView.image = image
        addPhotoButton.setTitle("", for: .normal)
    }
}

extension TodoEntryViewController: UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension TodoEntryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tapGestureRecognizer.isEnabled = true
    }
}
