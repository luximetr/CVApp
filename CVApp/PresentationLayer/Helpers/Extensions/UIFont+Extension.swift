//
//  UIFont+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIFont {
  
  enum FontFamily: String {
    case system
  }
  
  enum FontWeight: String {
    case regular = "Regular"
    case bold = "Bold"
    case semiBold = "SemiBold"
    case medium = "Medium"
  }
  
  static func font(ofSize size: CGFloat,
                   weight: FontWeight = .regular,
                   family: FontFamily = .system) -> UIFont {
    let fontName = "\(family.rawValue)-\(weight.rawValue)"
    guard let selectedFont = UIFont(name: fontName, size: size), family != .system else {
      return systemFont(ofSize: size, weight: convertToFontWeight(weight))
    }
    return selectedFont
  }
  
  private static func convertToFontWeight(_ weight: FontWeight) -> UIFont.Weight {
    switch weight {
    case .regular: return .regular
    case .bold: return .bold
    case .semiBold: return .semibold
    case .medium: return .medium
    }
  }
}
