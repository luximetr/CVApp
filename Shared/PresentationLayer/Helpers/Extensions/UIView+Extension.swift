//
//  UIView+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
  
  var safeArea: ConstraintBasicAttributesDSL {
      #if swift(>=3.2)
          if #available(iOS 11.0, *) {
              return self.safeAreaLayoutGuide.snp
          }
          return self.snp
      #else
          return self.snp
      #endif
  }
  
  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach { addSubview($0) }
  }
}
