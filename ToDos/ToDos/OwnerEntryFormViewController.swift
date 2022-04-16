//
//  OwnerEntryFormViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-16.
//

import Foundation
import UIKit

protocol PersonInputDelegate {
    func add(person: Person)
}

class OwnerEntryFormViewController: UITableViewController {

    @IBOutlet var firstNameTxtField: UITextField!
    @IBOutlet var lastNameTxtField: UITextField!
    @IBOutlet weak var ownerImageButton: UIButton!
    @IBOutlet weak var ownerImageView: UIImageView!

    let picker = UIImagePickerController()
    private var tapGestureRecognizer = UITapGestureRecognizer()
    var delegate: PersonInputDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = true
        picker.delegate = self
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        tableView.allowsSelection = false
        addTapGestureRecognizer()
    }

    //MARK: Helpers
    func configActionSheet() {
        let actionSheet = UIAlertController(title: "Photo", message: "Choose a source", preferredStyle: .actionSheet)
       
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.picker.sourceType = .camera
            self.present(self.picker,animated: true) }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker,animated: true) }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func cancelBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func saveBarButtonTapped() {
        guard let firstName = firstNameTxtField.text,
              let lastName = lastNameTxtField.text else { return }
        let newPerson = Person(firstName: firstName,
                               lastName: lastName,
                               image: ownerImageView.image,
                               todos: nil)
        delegate?.add(person: newPerson)
        dismiss(animated: true)
    }
    
    @IBAction func ownerPhotoButtonTapped(_ sender: UIButton) {
        configActionSheet()
    }

    private func addTapGestureRecognizer() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerTapped))
        tapGestureRecognizer.isEnabled = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func gestureRecognizerTapped() {
        view.endEditing(true)
        tapGestureRecognizer.isEnabled = false
    }
}

extension OwnerEntryFormViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ownerImageView.image = image
            ownerImageButton.setTitle("", for: .normal)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension OwnerEntryFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tapGestureRecognizer.isEnabled = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTxtField:
            lastNameTxtField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
