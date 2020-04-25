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
  
  func fetchCV() -> CV? {
//    let jsons = storage.fetchObjects(tableName: "CV")
    
    return nil
  }
}
