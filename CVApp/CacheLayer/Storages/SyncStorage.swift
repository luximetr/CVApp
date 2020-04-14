//
//  SyncStorage.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol SyncStorage {
  func saveObject(_ object: JSON, key: String)
  func getObject(key: String) -> JSON?
  func setValue<T>(_ value: T, key: String)
  func getValue<T>(key: String) -> T?
}
