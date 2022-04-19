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
    @IBOutlet var personImageView: UIImageView!

    var style = TodosViewController.Style.grouped

    override func prepareForReuse() {
        update(with: .none)
    }

    func update(with todo: Todo?) {
        if let todo = todo {
            switch style {
            case .grouped:
                personImageView.image = todo.owner.image
                personImageView.isHidden = false
            case .individual:
                personImageView.isHidden = true
            }

            if todo.isCompleted {
                todoTextLabel.attributedText = todo.title.strikeThrough
                timeLabel.attributedText = todo.date.shortDateString.strikeThrough
            } else {
                todoTextLabel.attributedText = todo.title.strikeThroughRemoved
                timeLabel.attributedText = todo.date.shortDateString.strikeThroughRemoved
            }
            priorityLabel.text = todo.priority.symbol
            priorityLabel.textColor = todo.priority.color
        } else {
            todoTextLabel.attributedText = .none
            timeLabel.attributedText = .none
            personImageView.image = .none
        }
    }
}
