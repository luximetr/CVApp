//
//  UserNumberJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserNumberJSONConvertor {
  
  // MARK: - JSON -> UserNumber
  
  func toUserNumber(json: JSON) -> UserNumber? {
    guard let value = json["value"] as? Int else { return nil }
    guard let title = json["title"] as? String else { return nil }
    
    return UserNumber(
      value: value,
      title: title)
  }
  
  // MARK: - UserNumber -> JSON
  
  func toJSON(userNumber: UserNumber) -> JSON {
    var json: JSON = [:]
    json["value"] = userNumber.value
    json["title"] = userNumber.title
    return json
  }
}
