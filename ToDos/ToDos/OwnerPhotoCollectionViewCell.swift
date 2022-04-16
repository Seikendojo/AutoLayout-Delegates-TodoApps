//
//  OwnerPhotoCollectionViewCell.swift
//  ToDos
//
//  Created by Sia on 2022-03-04.
//

import UIKit



class OwnerPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var ownerImageView: CircleImageView!

    override func prepareForReuse() {
        update(with: .none)
    }

    func update(with owner: Person?) {
        if let owner = owner {
            ownerImageView.image = owner.image
        } else {
            ownerImageView.image = .none
        }
    }

    func showAddButton() {
        ownerImageView.image = UIImage(named: "addNewOwner")
    }
}
