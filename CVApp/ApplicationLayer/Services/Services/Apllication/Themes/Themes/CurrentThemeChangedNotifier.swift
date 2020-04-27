//
//  CurrentThemeChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentThemeChangedObserver: class {
  func currentThemeChanged(_ theme: Theme)
}

class CurrentThemeChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentThemeChangedObserver) {
    observers.add(observer)
  }
  
  func notifyCurrentThemeChanged(_ theme: Theme) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentThemeChangedObserver else { return }
      observer.currentThemeChanged(theme)
    }
  }
}
