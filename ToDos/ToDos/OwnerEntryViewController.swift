//
//  OwnerEntryViewController.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-13.
//

import Foundation
import UIKit

class OwnerEntryViewController: UIViewController {

    @IBOutlet var ownerImageButton: UIButton!
    @IBOutlet var firstNameTxtField: UITextField!
    @IBOutlet var lastNameTxtField: UITextField!
    @IBOutlet weak var saveOwnerBarButton: UIBarButtonItem!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ownerImageButton.makeRoundedButton()
        picker.allowsEditing = true
        picker.delegate = self
        ownerImageButton.imageView?.contentMode = .scaleAspectFill
        ownerImageButton.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
      
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        configAlctionSheet()
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveOwnerBtnTapped(_ sender: UIBarButtonItem) {

    }
    
    //MARK: Helpers
    
    func configAlctionSheet() {
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
}


//MARK: Extensions

extension OwnerEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
