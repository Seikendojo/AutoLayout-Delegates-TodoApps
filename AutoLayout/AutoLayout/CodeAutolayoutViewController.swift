//
//  CodeAutolayoutViewController.swift
//  AutoLayout
//
//  Created by Shahin on 2021-11-20.
//

import UIKit

class CodeAutolayoutViewController: UIViewController {

    private let greenBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let midBlueBox: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topBlueBox: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomBlueBox: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var purpleBox: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var redBox:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var rectOrangeBox : UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var sqreOrangeBox : UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var squareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Square", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let portraitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Portrait", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let landscapeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Landscape", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var greenBoxHeightConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: greenBox,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .height,
                           multiplier: 0.8,
                           constant: .zero)
    }()
    private var greenBoxAspectRatioConstraint: NSLayoutConstraint

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.greenBoxAspectRatioConstraint = NSLayoutConstraint(item: greenBox,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: greenBox,
                                                                attribute: .height,
                                                                multiplier: 1/1,
                                                                constant: .zero)

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructView()
        constructViewHierarchy()
        constructViewAutolayoutConstraints()
    }

    private func constructView() {
        view.backgroundColor = .darkGray

        squareButton.addTarget(self, action: #selector(onSquareButtonTap), for: .touchUpInside)
        portraitButton.addTarget(self, action: #selector(onPortraitButtonTap), for: .touchUpInside)
        landscapeButton.addTarget(self, action: #selector(onLandscapeButtonTap), for: .touchUpInside)
    }

    private func constructViewHierarchy() {
        hStack.addArrangedSubview(squareButton)
        hStack.addArrangedSubview(portraitButton)
        hStack.addArrangedSubview(landscapeButton)
        view.addSubview(hStack)
        view.addSubview(greenBox)
        view.addSubview(purpleBox)
        view.addSubview(midBlueBox)
        view.addSubview(topBlueBox)
        view.addSubview(bottomBlueBox)
        view.addSubview(redBox)
        view.addSubview(rectOrangeBox)
        view.addSubview(sqreOrangeBox)
    }

    private func constructViewAutolayoutConstraints() {
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            greenBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greenBoxAspectRatioConstraint,
            greenBoxHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            midBlueBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            midBlueBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            midBlueBox.widthAnchor.constraint(equalTo: midBlueBox.heightAnchor),
            midBlueBox.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            topBlueBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBlueBox.topAnchor.constraint(lessThanOrEqualTo: greenBox.topAnchor, constant: 116),
            topBlueBox.bottomAnchor.constraint(equalTo: midBlueBox.topAnchor, constant: -130),
            topBlueBox.heightAnchor.constraint(equalTo: midBlueBox.heightAnchor),
            topBlueBox.widthAnchor.constraint(equalTo: topBlueBox.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomBlueBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomBlueBox.bottomAnchor.constraint(greaterThanOrEqualTo: greenBox.bottomAnchor, constant: -116),
            bottomBlueBox.topAnchor.constraint(equalTo: midBlueBox.bottomAnchor, constant: 130),
            bottomBlueBox.widthAnchor.constraint(equalTo: bottomBlueBox.heightAnchor),
            bottomBlueBox.heightAnchor.constraint(equalTo: midBlueBox.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            purpleBox.trailingAnchor.constraint(equalTo: greenBox.trailingAnchor,constant: -35),
            purpleBox.heightAnchor.constraint(equalToConstant: 80),
            purpleBox.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32),
            purpleBox.bottomAnchor.constraint(equalTo: greenBox.bottomAnchor, constant: -28.0)
        ])

        NSLayoutConstraint.activate([
            redBox.widthAnchor.constraint(equalToConstant: 264),
            redBox.heightAnchor.constraint(equalToConstant: 86),
            redBox.topAnchor.constraint(equalTo: greenBox.topAnchor,constant: 22),
            redBox.trailingAnchor.constraint(equalTo: greenBox.trailingAnchor,constant: -22)
        ])

        NSLayoutConstraint.activate([
            rectOrangeBox.widthAnchor.constraint(equalToConstant: 160),
            rectOrangeBox.heightAnchor.constraint(equalToConstant: 60),
            rectOrangeBox.topAnchor.constraint(equalTo: redBox.topAnchor, constant: 13),
            rectOrangeBox.leadingAnchor.constraint(equalTo: redBox.leadingAnchor, constant: 13)
        ])

        NSLayoutConstraint.activate([
            sqreOrangeBox.widthAnchor.constraint(equalToConstant: 60),
            sqreOrangeBox.heightAnchor.constraint(equalToConstant: 60),
            sqreOrangeBox.leadingAnchor.constraint(equalTo: rectOrangeBox.trailingAnchor, constant: 13),
            sqreOrangeBox.topAnchor.constraint(equalTo: redBox.topAnchor, constant: 13),
            sqreOrangeBox.trailingAnchor.constraint(equalTo: redBox.trailingAnchor, constant: -13)
        ])
    }

    @objc
    private func onSquareButtonTap() {
        changeMultiplier(for: &greenBoxAspectRatioConstraint, in: greenBox, using: 1/1)
        changeMultiplier(for: &greenBoxHeightConstraint, in: view, using: 0.8)
        animateConstraints()
    }

    @objc
    private func onPortraitButtonTap() {
        changeMultiplier(for: &greenBoxAspectRatioConstraint, in: greenBox, using: 2/3)
        changeMultiplier(for: &greenBoxHeightConstraint, in: view, using: 0.9)
        animateConstraints()
    }

    @objc
    private func onLandscapeButtonTap() {
        changeMultiplier(for: &greenBoxAspectRatioConstraint, in: greenBox, using: 3/2)
        changeMultiplier(for: &greenBoxHeightConstraint, in: view, using: 0.6)
        animateConstraints()
    }
}
