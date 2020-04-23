//
//  CurrentUserAvatarChangedNotifier.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol CurrentUserAvatarChangedObserver: class {
  func currentUserAvatarChanged(_ avatarURL: URL)
}

class CurrentUserAvatarChangedNotifier {
  
  // MARK: - Observers
  
  private let observers = NSHashTable<AnyObject>.weakObjects()
  
  func addObserver(_ observer: CurrentUserAvatarChangedObserver) {
    observers.add(observer)
  }
  
  // MARK: - Notify
  
  func notifyCurrentUserAvatarChanged(_ avatarURL: URL) {
    observers.allObjects.forEach { object in
      guard let observer = object as? CurrentUserAvatarChangedObserver else { return }
      observer.currentUserAvatarChanged(avatarURL)
    }
  }
}
