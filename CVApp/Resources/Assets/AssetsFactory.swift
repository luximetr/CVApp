//
//  AssetsFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AssetsFactory {
  
  static var left_arrow: UIImage {
    return createImage(named: "left_arrow")
  }
  
  private static func createImage(named: String) -> UIImage {
    return UIImage(named: named) ?? UIImage()
  }
}
