//
//  UserNumberJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserNumberJSONConvertor {
  
  func toUserNumber(json: JSON) -> UserNumber? {
    guard let value = json["value"] as? Int else { return nil }
    guard let title = json["title"] as? String else { return nil }
    
    return UserNumber(
      value: value,
      title: title)
  }
}
