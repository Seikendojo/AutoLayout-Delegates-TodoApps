//
//  OwnerEntryFormViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-16.
//

import Foundation
import UIKit

class OwnerEntryFormViewController: UIViewController {
    
    @IBOutlet var firstNameTxtField: UITextField!
    @IBOutlet var lastNameTxtField: UITextField!
    
    let picker = UIImagePickerController()
    let ownerImageButton = UIButton(frame: CGRect(x: 87, y: 165, width: 240, height: 240))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = true
        picker.delegate = self
        configOwnerPhotoButton()
    }
    
    //MARK: Helpers
    
    private func configOwnerPhotoButton() {
        ownerImageButton.setTitle("Add Photo", for: .normal)
        ownerImageButton.setTitleColor(.systemBlue, for: .normal)
        ownerImageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(ownerImageButton)
        ownerImageButton.makeRoundedButton()
        ownerImageButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    @objc
        func buttonAction() {
            configActionSheet()
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
    
    
}

extension OwnerEntryFormViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            ownerImageButton.makeRoundedButton()
            ownerImageButton.setImage(image, for: .normal)
            ownerImageButton.setTitle("", for: .normal)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
