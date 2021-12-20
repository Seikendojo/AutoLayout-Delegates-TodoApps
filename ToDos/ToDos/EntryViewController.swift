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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whatToDoTextFeild.becomeFirstResponder()
    }
    
    
    @IBAction func configureSegment(_ sender: UISegmentedControl) {
    
        let selectedIndex = priorityControl.isSelected
        if !selectedIndex {
            priorityControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
    }
}
