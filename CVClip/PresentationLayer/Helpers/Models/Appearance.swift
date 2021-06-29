//
//  Appearance.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 25.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

struct Appearance {
  
  // MARK: - Properties
  
  let background: Background
  let text: Text
  let navigation: Navigation
  
  // MARK: - Types
  
  struct Background {
    let primary: UIColor
    let secondary: UIColor
  }
  
  struct Text {
    let primary: UIColor
    let secondary: UIColor
    let disruptive: UIColor
    let positive: UIColor
  }
  
  struct Navigation {
    let background: UIColor
    let tint: UIColor
    let shadow: UIColor
  }
}
