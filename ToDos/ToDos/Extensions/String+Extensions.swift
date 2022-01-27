//
//  String+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2022-01-15.
//

import UIKit

extension String {
    var strikeThrough: NSAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: range)
        return attributedString
    }

    var strikeThroughRemoved: NSAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttribute(.strikethroughStyle, value: 0, range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        return attributedString
    }
}
