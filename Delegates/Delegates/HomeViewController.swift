//
//  HomeViewController.swift
//  Delegates
//
//  Created by Shahin on 2021-12-06.
//

import UIKit

enum Style {
    case morning
    case afternoon
    case evening
    case none

    init() {
        let now = Date()
        let hour = Calendar.current.component(.hour, from: now)

        let newDay = 0
        let noon = 12
        let sunset = 17
        let midnight = 24

        switch hour {
        case newDay..<noon:
            self = .morning
        case noon..<sunset:
            self = .afternoon
        case sunset..<midnight:
            self = .evening
        default:
            self = .none
        }
    }

    var greeting: String {
        switch self {
        case .morning:
            return "Good morning"
        case .afternoon:
            return "Good afternoon"
        case .evening:
            return "Good evening"
        case .none:
            return "Hello"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .morning:
            return UIColor.blue.withAlphaComponent(0.5)
        case .afternoon:
            return UIColor.yellow.withAlphaComponent(0.5)
        case .evening:
            return .blue
        case .none:
            return .white
        }
    }
}

class HomeViewController: UIViewController {

    private let style = Style()
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var inputButon: UIButton!

    @IBAction func onInputButtonTap(_ sender: UIButton) {
        performSegue(withIdentifier: "presentInput", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentInput" {
            let destinationVC = segue.destination as? InputViewContrller
            destinationVC?.view.backgroundColor = style.backgroundColor
            destinationVC?.delegate = self
        }
    }
}

extension HomeViewController: InputFormDelegate {
    func updateName(_ name: String) {
        greetingLabel.text = "\(style.greeting)\n\(name)"
    }
}
