//
//  CurrentUserCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CurrentUserCacheWorker {
  
  // MARK: - Properties
  
  private let storage: SyncStorage
  private let key = "currentUserKey"
  private let jsonConvertor = UserJSONConvertor()
  
  // MARK: - Life cycle
  
  init(storage: SyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Store user
  
  func saveUser(_ user: User) {
    let json = jsonConvertor.toJSON(user: user)
    storage.setObject(json, key: key)
  }
  
  func fetchCurrentUser() -> User? {
    guard let json = storage.getObject(key: key) else { return nil }
    return jsonConvertor.toUser(json: json)
  }
  
  func removeCurrentUser() {
    storage.removeObject(key: key)
  }
  
}
