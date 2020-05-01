//
//  CVUserNameChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CVUserNameChangedObserver: class {
  func cvUserNameChanged(_ name: String)
}

class CVUserNameChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  // MARK: - Add observer
  
  func addObserver(_ observer: CVUserNameChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCurrentUserNameChanged(_ name: String) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CVUserNameChangedObserver else { return }
      observer.cvUserNameChanged(name)
    }
  }
}
