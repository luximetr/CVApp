//
//  String+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 25/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

extension String {
  
  func capitalizingFirstLetter() -> String {
    guard !self.isEmpty else { return self }
    let first = String(prefix(1)).capitalized
    let other = String(dropFirst())
    return first + other
  }
  
  mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
  }
}
