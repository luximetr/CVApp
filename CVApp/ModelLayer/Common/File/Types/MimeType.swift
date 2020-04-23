//
//  MimeType.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

struct MimeType: StringRepresentable {
  
  // MARK: - Data
  
  let type: String
  let subtype: String
  
  // MARK: - StringRepresentable
  
  func toString() -> String {
    return type + "/" + subtype
  }
}
