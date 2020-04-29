//
//  AssetsFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AssetsFactory {
  
  static var cv: UIImage {
    return createImage(named: "cv")
  }
  
  static var edit: UIImage {
    return createImage(named: "edit")
  }
  
  static var email: UIImage {
    return createImage(named: "email")
  }
  
  static var left_arrow: UIImage {
    return createImage(named: "left_arrow")
  }
  
  static var linkedin: UIImage {
    return createImage(named: "linkedin")
  }
  
  static var network: UIImage {
    return createImage(named: "network")
  }
  
  static var phone: UIImage {
    return createImage(named: "phone")
  }
  
  static var settings: UIImage {
    return createImage(named: "settings")
  }
  
  static var telegram: UIImage {
    return createImage(named: "telegram")
  }
  
  static var tick: UIImage {
    return createImage(named: "tick")
  }
  
  private static func createImage(named: String) -> UIImage {
    return UIImage(named: named) ?? UIImage()
  }
}
