//
//  CurrentAppearanceChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentAppearanceChangedObserver: class {
  func currentAppearanceChanged(_ appearance: Appearance)
}

class CurrentAppearanceChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentAppearanceChangedObserver) {
    observers.add(observer)
  }
  
  func notifyCurrentAppearanceChanged(_ appearance: Appearance) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentAppearanceChangedObserver else { return }
      observer.currentAppearanceChanged(appearance)
    }
  }
}
