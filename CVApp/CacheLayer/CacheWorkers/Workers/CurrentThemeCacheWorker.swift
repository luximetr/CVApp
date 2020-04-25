//
//  CurrentThemeCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CurrentThemeCacheWorker {
  
  // MARK: - Storage
  
  private let storage: SyncStorage
  private let key = "currentThemeKey"
  
  // MARK: - Life cycle
  
  init(storage: SyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Current theme storing
  
  func saveCurrentTheme(type: ThemeType) {
    storage.setValue(type.rawValue, key: key)
  }
  
  func fetchCurrentThemeType() -> ThemeType? {
    guard let value: Int = storage.getValue(key: key) else { return nil }
    return ThemeType(rawValue: value)
  }
}
