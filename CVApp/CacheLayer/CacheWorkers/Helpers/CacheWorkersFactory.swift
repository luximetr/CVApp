//
//  CacheWorkersFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CacheWorkersFactory {
  
  // MARK: - Properties
  
  private let userDefaultsStorage: SyncStorage
  private let coreDataStorage: AsyncStorage
  
  // MARK: - Life cycle
  
  init() {
    userDefaultsStorage = UserDefaultsStorage(storage: .standard)
    coreDataStorage = CoreDataStorage(storageName: "CVApp", storeURL: nil)
  }
  
  // MARK: - Current User
  
  func createAuthTokenWorker() -> AuthTokenCacheWorker {
    return AuthTokenCacheWorker(storage: userDefaultsStorage)
  }
  
  // MARK: - Current theme
  
  func createCurrentThemeWorker() -> CurrentThemeCacheWorker {
    return CurrentThemeCacheWorker(storage: userDefaultsStorage)
  }
  
  // MARK: - Current language
  
  func createCurrentLanguageWorker() -> CurrentLanguageCacheWorker {
    return CurrentLanguageCacheWorker(storage: userDefaultsStorage)
  }
}
