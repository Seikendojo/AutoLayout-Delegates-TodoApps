//
//  OwnerPopupViewController.swift
//  ToDos
//
//  Created by Sia on 2022-03-04.
//

import UIKit

protocol OwnerSelectionDelegate {
    func didSelect(_ owner: Person)
    func showOwnerInputScreen()
}

class OwnerPopupViewController: UIViewController {

    var photoSelectionDelegate: OwnerSelectionDelegate?
    
    var owners: [Person] {
        PersistenceManager.shared.people
    }
}

extension OwnerPopupViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        owners.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ownerCell", for: indexPath) as! OwnerPhotoCollectionViewCell
        if indexPath.row == owners.count {
            cell.showAddButton()
        } else {
            let owner = owners[indexPath.row]
            cell.update(with: owner)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
        if indexPath.row == owners.count {
            photoSelectionDelegate?.showOwnerInputScreen()
        } else {
            let owner = owners[indexPath.row]
            photoSelectionDelegate?.didSelect(owner)
        }
   }
}
