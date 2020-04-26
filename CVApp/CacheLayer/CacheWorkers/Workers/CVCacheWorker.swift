//
//  CVCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 25/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CVCacheWorker {
  
  // MARK: - Dependencies
  
  private let storage: AsyncStorage
  private let cvJSONConvertor = CVJSONConvertor()
  
  // MARK: - Life cycle
  
  init(storage: AsyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Save CV
  
  func saveCV(_ cv: CV, completion: @escaping () -> Void) {
    let json = cvJSONConvertor.toJSON(cv: cv)
    storage.storeObject("CV", json: json, completion: completion)
  }
  
  func updateCVAvatar(_ cvId: CVIdType, avatarURL: URL, completion: @escaping () -> Void) {
    let json = cvJSONConvertor.toJSON(avatarURL: avatarURL)
    storage.updateObject("CV", id: cvId, json: json, completion: completion)
  }
  
  func fetchCV() -> CV? {
    guard let json = storage.fetchObjects(tableName: "CV")?.first else { return nil }
    return cvJSONConvertor.toCV(json: json)
  }
}
