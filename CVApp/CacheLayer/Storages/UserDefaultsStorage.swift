//
//  UserDefaultsStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserDefaultsStorage: SyncStorage {
  
  // MARK: - Storage
  
  private let storage: UserDefaults
  
  // MARK: - Life cycle
  
  init(storage: UserDefaults) {
    self.storage = storage
  }
  
  // MARK: - Store object
  
  func saveObject(_ object: JSON, key: String) {
    storage.set(object, forKey: key)
  }
  
  func getObject(key: String) -> JSON? {
    return storage.value(forKey: key) as? JSON
  }
  
  // MARK: - Store value
  
  func setValue<T>(_ value: T, key: String) {
    storage.set(value, forKey: key)
  }
  
  func getValue<T>(key: String) -> T? {
    return storage.value(forKey: key) as? T
  }
}
