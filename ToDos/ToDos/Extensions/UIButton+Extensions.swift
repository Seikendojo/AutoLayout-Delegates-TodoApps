//
//  UIButton+Extensions.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-13.
//

import Foundation
import UIKit


extension UIButton {
    func makeRoundedButton() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = self.frame.width / 2
        self.imageView?.layer.cornerRadius = self.frame.width / 2
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
    }
}
