//
//  AuthTokenCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthTokenCacheWorker {
  
  // MARK: - Dependencies
  
  private let storage: SyncStorage
  private let key = "authTokenKey"
  
  // MARK: - Life cycle
  
  init(storage: SyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Token storing
  
  func saveToken(_ token: String) {
    storage.setValue(token, key: key)
  }
  
  func fetchToken() -> String? {
    return storage.getValue(key: key)
  }
  
  func removeToken() {
    storage.removeObject(key: key)
  }
}
