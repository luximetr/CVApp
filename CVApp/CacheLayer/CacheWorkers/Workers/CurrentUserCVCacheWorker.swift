//
//  CurrentUserCVCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CurrentUserCVCacheWorker {
  
  // MARK: - Dependencies
  
  private let storage: AsyncStorage
  private let cvJSONConvertor = CVJSONConvertor()
  private let tableName = "CurrentUserCV"
  
  // MARK: - Life cycle
  
  init(storage: AsyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Storing
  
  func saveCV(_ cv: CV, completion: @escaping VoidAction) {
    let object = toStoringObject(cv: cv)
    storage.storeObject(tableName, object: object, completion: completion)
  }
  
  func fetchCV() -> CV? {
    guard let json = storage.fetchObjects(tableName: tableName)?.first else { return nil }
    return cvJSONConvertor.toCV(json: json)
  }
  
  func updateCVAvatar(_ cvId: CVIdType, avatarURL: URL, completion: @escaping () -> Void) {
    let json = cvJSONConvertor.toJSON(avatarURL: avatarURL)
    storage.updateObject(tableName, object: .init(id: cvId, json: json), completion: completion)
  }
  
  // MARK: - Helpers
  
  private func toStoringObject(cv: CV) -> AsyncStoringObject {
    let json = cvJSONConvertor.toJSON(cv: cv)
    return .init(id: cv.id, json: json)
  }
}
