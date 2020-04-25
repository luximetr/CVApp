//
//  UIAlertController+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 25/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  func setBackgroundColor(_ color: UIColor) {
    if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }
  
  func setTitleColor(_ color: UIColor) {
    guard let title = self.title else { return }
    let attributes: [NSAttributedString.Key: Any] = [
      .font : UIFont.font(ofSize: 18),
      .foregroundColor: color
    ]
    let attributeString = NSAttributedString(string: title, attributes: attributes)
    self.setValue(attributeString, forKey: "attributedTitle")
  }
  
  func setMessageColor(_ color: UIColor) {
    guard let message = self.message else { return }
    let attributes: [NSAttributedString.Key: Any] = [
      .font : UIFont.font(ofSize: 12),
      .foregroundColor: color
    ]
    let attributeString = NSAttributedString(string: message, attributes: attributes)
    self.setValue(attributeString, forKey: "attributedMessage")
  }
  
  func setTintColor(_ color: UIColor) {
    self.view.tintColor = color
  }
}
