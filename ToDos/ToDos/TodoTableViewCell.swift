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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(with todo: Todo) {
        todoTextLabel.text = todo.title
        timeLabel.text = todo.date.shortDateString
        priorityLabel.text = todo.priority.symbol
        priorityLabel.textColor = todo.priority.color
    }
}
