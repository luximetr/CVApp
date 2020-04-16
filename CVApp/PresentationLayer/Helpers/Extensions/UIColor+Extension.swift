//
//  UIColor+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
      return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
  }
}
