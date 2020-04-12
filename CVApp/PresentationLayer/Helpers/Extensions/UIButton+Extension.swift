//
//  UIButton+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIButton {
  
  var title: String? {
    set { setTitle(newValue, for: .normal) }
    get { return titleLabel?.text }
  }
}
