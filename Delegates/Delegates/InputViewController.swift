//
//  InputViewController.swift
//  Delegates
//
//  Created by Shahin on 2021-12-06.
//

import UIKit

protocol InputFormDelegate: AnyObject {
    func updateName(_ name: String)
}

class InputViewContrller: UIViewController {
    
    weak var delegate: InputFormDelegate?
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!

   

    @IBAction func onSaveTap(_ sender: UIButton) {
        guard let name = nameTextfield.text, !name.isEmpty else { return }
        delegate?.updateName(name)
        dismiss(animated: true)
    }
}
