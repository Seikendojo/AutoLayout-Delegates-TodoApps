//
//  OwnerEntryFormViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-16.
//

import Foundation
import UIKit

class OwnerEntryFormViewController: UIViewController {
    private struct Constants {
        static let keyboardOffset = CGPoint(x: 0, y: 40)
    }

    @IBOutlet var firstNameTxtField: UITextField!
    @IBOutlet var lastNameTxtField: UITextField!
    @IBOutlet weak var ownerImageButton: UIButton!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!

    let picker = UIImagePickerController()
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = true
        picker.delegate = self
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        addTapGestureRecognizer()
        registerNotifications()
    }

    //MARK: Helpers
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

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
        print("Save tapped")
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
        keyboardWillHide()
    }

    @objc private func keyboardWillShow() {
        scrollView.setContentOffset(Constants.keyboardOffset, animated: true)
    }

    @objc private func keyboardWillHide() {
        scrollView.setContentOffset(.zero, animated: true)
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
}
