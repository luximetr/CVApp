//
//  CurrentUserNameChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentUserNameChangedObserver: class {
  func currentUserNameChanged(_ name: String)
}

class CurrentUserNameChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentUserNameChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCurrentUserNameChanged(_ name: String) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentUserNameChangedObserver else { return }
      observer.currentUserNameChanged(name)
    }
  }
}
