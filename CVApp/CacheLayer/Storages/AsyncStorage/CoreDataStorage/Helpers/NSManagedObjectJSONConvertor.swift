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
      if let propertyObject = object.value(forKey: key) as? NSManagedObject {
        guard let propertyJSON = toJSON(object: propertyObject) else { continue }
        json[key] = propertyJSON
      } else if let propertySet = object.value(forKey: key) as? NSSet, propertySet.count == 0 {
        
      } else {
        guard let value = object.value(forKey: key) else { continue }
        json[key] = value
      }
    }
    return json
  }
  
  func fillObject(_ object: NSManagedObject, json: JSON) {
    for (_, (key, value)) in json.enumerated() {
      object.setValue(value, forKey: key)
    }
  }
}
