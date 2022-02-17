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
                timeLabel.attributedText = todo.date.shortDateString.strikeThrough
                
            } else {
                todoTextLabel.attributedText = todo.title.strikeThroughRemoved
                timeLabel.attributedText = todo.date.shortDateString.strikeThroughRemoved
                let indexPath = IndexPath(row: 0, section: 0)
                todoTextLabel?.text =  todoStore.allTodos[indexPath.section][indexPath.row].title
            }
            priorityLabel.text = todo.priority.symbol
            priorityLabel.textColor = todo.priority.color
        } else {
            todoTextLabel.attributedText = .none
            timeLabel.attributedText = .none
        }
    }
}
