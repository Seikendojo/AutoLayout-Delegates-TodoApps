//
//  OwnersTableViewCell.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-10.
//

import UIKit

class OwnersTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerFullName: UILabel!
    @IBOutlet weak var ownerImageView: CircleImageView!
    
    override func prepareForReuse() {
        update(with: .none)
    }

    func update(with person: Person?) {
        if let person = person {
            ownerImageView.image = person.image
            ownerFullName.text = person.fullName
        } else {
            ownerImageView.image = .none
            ownerFullName.text = .none
        }
    }
}
