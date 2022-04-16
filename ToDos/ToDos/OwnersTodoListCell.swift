//
//  OwnersTodoListCell.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-04-11.
//

import Foundation
import UIKit

class OwnersTodoListCell: UITableViewCell {
    
    @IBOutlet weak var todoTextLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updatePersonCell(with todo: Todo?) {
        if let todo = todo {
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
        }
    }
}
