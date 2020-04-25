//
//  MessangerContactJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class MessangerContactJSONConvertor {
  
  // MARK: - JSON -> MessangerContact
  
  func toMessangerContact(json: JSON) -> MessangerContact? {
    guard let typeRawValue = json["type"] as? String else { return nil }
    guard let type = MessangerContactType(rawValue: typeRawValue) else { return nil }
    guard let linkString = json["link"] as? String else { return nil }
    guard let link = URL(string: linkString) else { return nil }
    
    return MessangerContact(
      type: type,
      link: link)
  }
  
  // MARK: - MessangerContact -> JSON
  
  func toJSON(messangerContact: MessangerContact) -> JSON {
    var json: JSON = [:]
    json["type"] = messangerContact.type.rawValue
    json["link"] = messangerContact.link.absoluteString
    return json
  }
}
