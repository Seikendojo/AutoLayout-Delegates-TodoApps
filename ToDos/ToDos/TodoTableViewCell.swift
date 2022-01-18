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

    override func prepareForReuse() {
        updateCell(with: .none)
    }

    func updateCell(with todo: Todo?) {
        if let todo = todo {
            if todo.isCompleted {
                todoTextLabel.attributedText = todo.title.strikeThrough
            } else {
                todoTextLabel.text = todo.title
            }
            timeLabel.text = todo.date.shortDateString
            priorityLabel.text = todo.priority.symbol
            priorityLabel.textColor = todo.priority.color
        } else {
            todoTextLabel.text = .none
            timeLabel.text = .none
            priorityLabel.text = .none
        }
    }
}
