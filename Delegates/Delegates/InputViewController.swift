//
//  InputViewController.swift
//  Delegates
//
//  Created by Shahin on 2021-12-06.
//

import UIKit

class InputViewContrller: UIViewController {
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var onSaveTap: ((String) -> Void)?

    @IBAction func onSaveTap(_ sender: UIButton) {
        guard let name = nameTextfield.text, !name.isEmpty else { return }
        onSaveTap?(name)
        dismiss(animated: true)
    }
}
