//
//  CurrentUserRoleChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentUserRoleChangedObserver: class {
  func currentUserRoleChanged(_ role: String)
}

class CurrentUserRoleChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentUserRoleChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCurrentUserRoleChanged(_ role: String) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentUserRoleChangedObserver else { return }
      observer.currentUserRoleChanged(role)
    }
  }
}
