//
//  InputViewController.swift
//  Delegates
//
//  Created by Shahin on 2021-12-06.
//

import UIKit

protocol InputDelegate {
    func delegateAction(name: String, greeting: String, backGround color: UIColor)
}

class InputViewContrller: UIViewController {
    
    var delegate : InputDelegate!
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!

   

    @IBAction func onSaveTap(_ sender: UIButton) {
        let name = nameTextfield.text
        let greeting = "Good Morning \(name!)!"
        
        delegate.delegateAction(name: name!, greeting: greeting, backGround: .cyan)
        dismiss(animated: true)
    }
}
