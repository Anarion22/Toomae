//
//  File.swift
//  Toomae
//
//  Created by Matija Sabljak on 09/02/2017.
//  Copyright © 2017 Matija Sabljak. All rights reserved.
//
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
