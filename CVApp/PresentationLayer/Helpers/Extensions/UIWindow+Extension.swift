//
//  UIWindow+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 1/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIWindow {
  
  func replaceRootVC(
      _ vc: UIViewController,
      animation: UIView.AnimationOptions,
      duration: TimeInterval = 0.3) {
    rootViewController = vc
    UIView.transition(with: self, duration: duration, options: animation, animations: {}, completion: { _ in })
  }
}
