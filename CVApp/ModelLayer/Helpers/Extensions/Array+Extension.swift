//
//  Array+Extension.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

extension Array {
  
  func getElement(at index: Int) -> Element? {
    guard index >= 0 && index < count else { return nil }
    return self[index]
  }
  
}
