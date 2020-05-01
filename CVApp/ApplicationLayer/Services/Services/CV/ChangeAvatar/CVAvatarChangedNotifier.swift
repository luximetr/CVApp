//
//  CVAvatarChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CVAvatarChangedObserver: class {
  func cvAvatarChanged(_ avatarURL: URL)
}

class CVAvatarChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  // MARK: - Add observer
  
  func addObserver(_ observer: CVAvatarChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCVAvatarChanged(_ avatarURL: URL) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CVAvatarChangedObserver else { return }
      observer.cvAvatarChanged(avatarURL)
    }
  }
}
