//
//  UserJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserJSONConvertor {
  
  func toUser(json: JSON) -> User? {
    guard let phoneNumber = json["phone"] as? String else { return nil }
    let name = json["name"] as? String
    return User(name: name, phoneNumber: phoneNumber)
  }
}
