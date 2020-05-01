//
//  AsyncStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol AsyncStorage {
  func storeObject(_ tableName: String, object: AsyncStoringObject, completion: VoidAction?)
  func storeObjects(_ tableName: String, objects: [AsyncStoringObject], completion: VoidAction?)
  func updateObject(_ tableName: String, object: AsyncStoringObject, completion: VoidAction?)
  func fetchObjects(tableName: String) -> [JSON]?
  func removeAllObjects(tableName: String)
}

struct AsyncStoringObject {
  let id: String
  let json: JSON
}
