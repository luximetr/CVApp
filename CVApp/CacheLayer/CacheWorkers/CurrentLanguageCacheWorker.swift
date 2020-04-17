//
//  CurrentLanguageCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CurrentLanguageCacheWorker {
  
  // MARK: - Storage
  
  private let storage: SyncStorage
  private let key = "currentLanguageKey"
  
  // MARK: - Life cycle
  
  init(storage: SyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Storing
  
  func saveCurrentLanguage(code: ISO639_1Code) {
    storage.setValue(code.rawValue, key: key)
  }
  
  func fetchCurrentLanguageCode() -> ISO639_1Code? {
    guard let rawValue: String = storage.getValue(key: key) else { return nil }
    return ISO639_1Code(rawValue: rawValue)
  }
  
}
