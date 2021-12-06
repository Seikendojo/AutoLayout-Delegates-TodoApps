//
//  HomeViewController.swift
//  AutoLayout
//
//  Created by Shahin on 2021-11-20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func onCodeTap(_ sender: UIButton) {
        let viewController = CodeAutolayoutViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
