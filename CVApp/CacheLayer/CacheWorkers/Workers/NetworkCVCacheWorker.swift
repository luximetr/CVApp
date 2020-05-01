//
//  NetworkCVCacheWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class NetworkCVCacheWorker {
  
  // MARK: - Dependencies
  
  private let storage: AsyncStorage
  private let cvJSONConvertor = CVJSONConvertor()
  private let tableName = "NetworkCV"
  
  // MARK: - Life cycle
  
  init(storage: AsyncStorage) {
    self.storage = storage
  }
  
  // MARK: - Storing
  
  func storeCVs(_ CVs: [CV], completion: @escaping VoidAction) {
    let objects = toStoringObjects(CVs: CVs)
    storage.storeObjects(tableName, objects: objects, completion: completion)
  }
  
  func fetchCVs() -> [CV]? {
    guard let jsons = storage.fetchObjects(tableName: tableName) else { return nil }
    return jsons.compactMap { cvJSONConvertor.toCV(json: $0) }
  }
  
  func removeAll() {
    storage.removeAllObjects(tableName: tableName)
  }
  
  // MARK: - Helpers
  
  private func toStoringObjects(CVs: [CV]) -> [AsyncStoringObject] {
    return CVs.map { toStoringObject(cv: $0) }
  }
  
  private func toStoringObject(cv: CV) -> AsyncStoringObject {
    let json = cvJSONConvertor.toJSON(cv: cv)
    return .init(id: cv.id, json: json)
  }
}
