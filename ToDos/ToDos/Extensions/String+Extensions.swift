//
//  String+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2022-01-15.
//

import Foundation

extension String {
    var strikeThrough: NSAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
