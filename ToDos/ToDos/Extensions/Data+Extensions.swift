//
//  Data+Extensions.swift
//  ToDos
//
//  Created by Shahin on 2022-05-14.
//

import UIKit

extension Data {
    var image: UIImage? {
        let image = UIImage(data: self)

        guard let img = image, img.imageOrientation == .up else {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }
}
