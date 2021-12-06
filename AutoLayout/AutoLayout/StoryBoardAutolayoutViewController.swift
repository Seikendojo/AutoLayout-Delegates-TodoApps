//
//  StoryBoardAutolayoutViewController.swift
//  AutoLayout
//
//  Created by Shahin on 2021-11-17.
//

import UIKit

class StoryBoardAutolayoutViewController: UIViewController {

    @IBOutlet weak var greenAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var greenboxHeightConstraint: NSLayoutConstraint!

    @IBAction func onSquareButtonTap(_ sender: UIButton) {
        changeMultiplier(for: &greenboxHeightConstraint, in: view, using: 0.8)
        changeMultiplier(for: &greenAspectRatioConstraint, in: greenView, using: 1/1)
        animateConstraints()
    }

    @IBAction func onPortraitButtonTap(_ sender: UIButton) {
        changeMultiplier(for: &greenboxHeightConstraint, in: view, using: 0.9)
        changeMultiplier(for: &greenAspectRatioConstraint, in: greenView, using: 2/3)
        animateConstraints()
    }

    @IBAction func onLandscapeButtonTap(_ sender: UIButton) {
        changeMultiplier(for: &greenboxHeightConstraint, in: view, using: 0.6)
        changeMultiplier(for: &greenAspectRatioConstraint, in: greenView, using: 3/2)
        animateConstraints()
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint(item: firstItem!,
                           attribute: firstAttribute,
                           relatedBy: relation,
                           toItem: secondItem,
                           attribute: secondAttribute,
                           multiplier: multiplier,
                           constant: constant)
    }
}

extension UIViewController {
    func changeMultiplier(for constraintToChange: inout NSLayoutConstraint, in view: UIView, using multiplier: CGFloat) {
        let newConstraint = constraintToChange.constraintWithMultiplier(multiplier)
        view.removeConstraint(constraintToChange)
        view.addConstraint(newConstraint)
        constraintToChange = newConstraint
    }
    
    func animateConstraints() {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
