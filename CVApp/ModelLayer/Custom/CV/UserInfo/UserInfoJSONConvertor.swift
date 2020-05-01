//
//  UserInfoJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserInfoJSONConvertor {
  
  func toUserInfo(json: JSON) -> UserInfo? {
    let avatarURLString = json["avatarURL"] as? String
    let avatarURL = URL(string: avatarURLString ?? "")
    let name = json["name"] as? String
    let role = json["role"] as? String
    
    return UserInfo(
      avatarURL: avatarURL,
      name: name ?? "",
      role: role ?? "")
  }
  
  // MARK: - To json
  
  func toJSON(userInfo: UserInfo) -> JSON {
    var json: JSON = [:]
    if let avatarURL = userInfo.avatarURL?.absoluteString {
      json["avatarURL"] = avatarURL
    }
    json["name"] = userInfo.name
    json["role"] = userInfo.role
    return json
  }
  
  func toJSON(avatarURL: URL) -> JSON {
    return ["avatarURL": avatarURL.absoluteString]
  }
  
  func toJSON(name: String) -> JSON {
    return ["name": name]
  }
  
  func toJSON(role: String) -> JSON {
    return ["role": role]
  }
}
