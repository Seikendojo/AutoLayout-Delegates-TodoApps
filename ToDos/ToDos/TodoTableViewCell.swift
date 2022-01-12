//
//  TodoTableViewCell.swift
//  ToDos
//
//  Created by Sia on 2021-12-19.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet private var todoTextLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var priorityLabel: UILabel!
    
      func strikeThroughText() {
        guard let text = todoTextLabel.text else { return }
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        todoTextLabel.attributedText = attributedString
    }
    
    func updateCell(with todo: Todo) {
        todoTextLabel.text = todo.title
        timeLabel.text = todo.date.shortDateString
        priorityLabel.text = todo.priority.symbol
        priorityLabel.textColor = todo.priority.color
    }
}



