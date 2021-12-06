//
//  HomeViewController.swift
//  Delegates
//
//  Created by Shahin on 2021-12-06.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var inputButon: UIButton!

    @IBAction func onInputButtonTap(_ sender: UIButton) {
        performSegue(withIdentifier: "presentInput", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentInput" {
            let destinationVC = segue.destination as? InputViewContrller
            destinationVC?.onSaveTap = updateGreeting
        }
    }

    private func updateGreeting(name: String) {
        greetingLabel.text = "Good Morning\n\(name)"
    }
}
