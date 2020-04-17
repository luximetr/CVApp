//
//  CurrentLanguageChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentLanguageChangedObserver: class {
  func currentLanguageChanged(_ language: Language)
}

class CurrentLanguageChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentLanguageChangedObserver) {
    observers.add(observer)
  }
  
  func notifyCurrentLanguageChanged(_ language: Language) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentLanguageChangedObserver else { return }
      observer.currentLanguageChanged(language)
    }
  }
  
}
