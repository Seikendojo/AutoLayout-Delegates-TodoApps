//
//  TableViewCell.swift
//  ToDos
//
//  Created by Sia on 2021-12-19.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var todoTextLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priorityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
