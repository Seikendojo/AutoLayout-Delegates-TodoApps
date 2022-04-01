//
//  CircleImageView.swift
//  ToDos
//
//  Created by Shahin on 2022-03-27.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageView()
    }

    fileprivate func configureImageView() {
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
