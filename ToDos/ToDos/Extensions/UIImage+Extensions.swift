//
//  UIImage+Extensions.swift
//  ToDos
//
//  Created by Sia on 2022-03-03.
//

import Foundation
import UIKit

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
