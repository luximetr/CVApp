//
//  CVUserRoleChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CVUserRoleChangedObserver: class {
  func cvUserRoleChanged(_ role: String)
}

class CVUserRoleChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  // MARK: - Add observer
  
  func addObserver(_ observer: CVUserRoleChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCVUserRoleChanged(_ role: String) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CVUserRoleChangedObserver else { return }
      observer.cvUserRoleChanged(role)
    }
  }
}
