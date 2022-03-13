//
//  OwnersTableViewCell.swift
//  ToDos
//
//  Created by Seiken Dojo on 2022-03-10.
//

import UIKit

class OwnersTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerFullName: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    
    override func prepareForReuse() {
        updateOwnerCell(with: .none)
    }

    func updateOwnerCell(with person: Person?) {
        if let person = person {
            ownerImageView.makeRounded()
            ownerImageView.image = person.image
            ownerFullName.text = person.fullName
    }
  }
}
