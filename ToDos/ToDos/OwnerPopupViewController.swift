//
//  OwnerPopupViewController.swift
//  ToDos
//
//  Created by Sia on 2022-03-04.
//

import UIKit

protocol ownerPhotoSelectionDelegate {
    func didTapChoice(image: UIImage)
}

class OwnerPopupViewController: UIViewController {

    var photoSelectionDelegate: ownerPhotoSelectionDelegate!
    
    var ownerPhotosData = ["Bruce","SteveMcQueen","HalleBerry","Arnold","BradPitt","RobertDeNiro","Bruce","SteveMcQueen","HalleBerry","Arnold","BradPitt","RobertDeNiro","Bruce","SteveMcQueen","HalleBerry","Arnold","BradPitt","RobertDeNiro","Bruce","SteveMcQueen","HalleBerry","Arnold","BradPitt","RobertDeNiro"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension OwnerPopupViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ownerPhotosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ownerCell", for: indexPath) as! OwnerPhotoCollectionViewCell
        cell.ownerImageView.image = UIImage(named: ownerPhotosData[indexPath.row])
        cell.layer.cornerRadius = cell.frame.height/2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = UIImage(named: ownerPhotosData[indexPath.row]) else { return }
        print(image)
        photoSelectionDelegate?.didTapChoice(image:image )
        dismiss(animated: true)
   }
}
