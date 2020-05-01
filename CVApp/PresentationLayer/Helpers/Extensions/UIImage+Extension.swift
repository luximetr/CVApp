//
//  UIImage+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 1/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIImage {
  
  static func image(color: UIColor, rect: CGRect) -> UIImage {
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()

    context?.setFillColor(color.cgColor)
    context?.fill(rect)

    let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    UIGraphicsEndImageContext()

    return image
  }
}
