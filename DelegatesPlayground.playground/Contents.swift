//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


class OurTextField: UITextField {
    weak var textFieldDelegate: TextFieldProtocol?
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        textFieldDelegate?.didBeginEditing()
    }
}

protocol TextFieldProtocol: AnyObject {
    func didBeginEditing()
}

class MyViewController: UIViewController, TextFieldProtocol {
    func didBeginEditing() {
        view.backgroundColor = .orange
    }

    let textField = OurTextField()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        textField.textFieldDelegate = self

        textField.placeholder = "Type your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect

        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            textField.widthAnchor.constraint(equalToConstant: 250.0)
        ])

        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

