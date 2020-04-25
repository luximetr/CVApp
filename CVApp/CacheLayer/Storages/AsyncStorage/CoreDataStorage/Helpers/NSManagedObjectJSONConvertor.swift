//
//  NSManagedObjectJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 25/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation
import CoreData

class NSManagedObjectJSONConvertor {
  
  func toJSON(object: NSManagedObject) -> JSON? {
    var json: JSON = [:]
    for property in object.entity.properties {
      let key = property.name
      json[key] = object.value(forKey: key)
    }
    return json
  }
  
  func fillObject(_ object: NSManagedObject, json: JSON) {
    for (_, (key, value)) in json.enumerated() {
      object.setValue(value, forKey: key)
    }
  }
}
