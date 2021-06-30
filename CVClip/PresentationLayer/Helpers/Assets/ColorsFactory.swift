//
//  ColorsFactory.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 30.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ColorsFactory {
  
  static var backgroundPrimary: UIColor {
    return createColor(named: "backgroundPrimary")
  }
  
  static var textPrimary: UIColor {
    return createColor(named: "textPrimary")
  }
  
  static var textSecondary: UIColor {
    return createColor(named: "textSecondary")
  }
  
  private static func createColor(named: String) -> UIColor {
    return UIColor(named: named) ?? .white
  }
}
