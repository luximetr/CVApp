//
//  AsyncStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol AsyncStorage {
  func storeObject(_ tableName: String, json: JSON, completion: @escaping () -> Void)
  func updateObject(_ tableName: String, id: String, json: JSON, completion: @escaping () -> Void)
  func fetchObjects(tableName: String) -> [JSON]?
}
