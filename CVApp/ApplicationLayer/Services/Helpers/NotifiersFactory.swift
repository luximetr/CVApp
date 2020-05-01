//
//  NotifiersFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class NotifiersFactory {
  
  // MARK: - Dependencies
  
  private let referenceStorage: ReferenceStorage
  
  // MARK: - Life cycle
  
  init(referenceStorage: ReferenceStorage) {
    self.referenceStorage = referenceStorage
  }
  
  // MARK: - CV
  
  func createCVUserRoleChangedNotifier() -> CVUserRoleChangedNotifier {
    let key = "cvUserRoleChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CVUserRoleChangedNotifier {
      return notifier
    } else {
      let notifier = CVUserRoleChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
  
  func createCVUserNameChangedNotifier() -> CVUserNameChangedNotifier {
    let key = "cvUserNameChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CVUserNameChangedNotifier {
      return notifier
    } else {
      let notifier = CVUserNameChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
  
  func createCVUserAvatarChangedNotifier() -> CVAvatarChangedNotifier {
    let key = "cvUserAvatarChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CVAvatarChangedNotifier {
      return notifier
    } else {
      let notifier = CVAvatarChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
  
  // MARK: - Theme
  
  func createCurrentThemeChangedNotifier() -> CurrentThemeChangedNotifier {
    let key = "currentThemeChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CurrentThemeChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentThemeChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
  
  // MARK: - Appearance
  
  func createCurrentAppearanceChangedNotifier() -> CurrentAppearanceChangedNotifier {
    let key = "currentAppearanceChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CurrentAppearanceChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentAppearanceChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
  
  // MARK: - Language
  
  func createCurrentLanguageChangedNotifier() -> CurrentLanguageChangedNotifier {
    let key = "currentLanguageChangedNotifier"
    if let notifier = referenceStorage.getObject(key) as? CurrentLanguageChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentLanguageChangedNotifier()
      referenceStorage.storeObject(key, object: notifier)
      return notifier
    }
  }
}
