//
//  ReferenceStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 28/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ReferenceStorage {
  
  // MARK: - Data
  
  private var storedObjects: [AnyObject] = []
  private var storedObjectsByKeys: [String: AnyObject] = [:]
  
  // MARK: - Store
  
  func storeObject(_ object: AnyObject) {
    storedObjects.append(object)
  }
  
  func removeObject(_ object: AnyObject) {
    storedObjects.removeAll(where: { object === $0 })
  }
  
  func storeObject(_ key: String, object: AnyObject) {
    storedObjectsByKeys[key] = object
  }
  
  func removeObject(_ key: String) {
    storedObjectsByKeys.removeValue(forKey: key)
  }
  
  func getObject(_ key: String) -> AnyObject? {
    return storedObjectsByKeys[key]
  }
  
}
