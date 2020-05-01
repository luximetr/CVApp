//
//  UITabBar+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 1/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UITabBar {
  
  open override var backgroundColor: UIColor? {
    set {
      let newColor = newValue ?? .clear
      let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
      backgroundImage = UIImage.image(color: newColor, rect: rect)
    }
    get { return super.backgroundColor }
  }
  
  var shadowColor: UIColor {
    set {
      let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
      shadowImage = UIImage.image(color: newValue, rect: rect)
    }
    get { return tintColor }
  }
}
