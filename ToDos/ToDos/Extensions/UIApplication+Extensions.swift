//
//  UIApplication+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2022-05-15.
//

import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}

