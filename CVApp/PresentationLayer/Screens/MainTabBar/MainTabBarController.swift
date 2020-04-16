//
//  MainTabBarController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, CurrentAppearanceChangedObserver {
  
  // MARK: - Dependencies
  
  var coordinator: MainTabBarCoordinator!
  var appearanceService: AppearanceService! {
    didSet { appearanceService.addCurrentAppearanceChanged(observer: self) }
  }
  
  // MARK: - Setup
  
  func setup() {
    tabBar.isTranslucent = false
    setSelf(appearance: appearanceService.getCurrentAppearance())
  }
  
  // MARK: - CurrentAppearanceChangedObserver
  
  func currentAppearanceChanged(_ appearance: Appearance) {
    setSelf(appearance: appearance)
  }
  
  private func setSelf(appearance: Appearance) {
    tabBar.barTintColor = appearance.tabBarBackgroundColor
    tabBar.tintColor = appearance.tabBarSelectedTintColor
    tabBar.unselectedItemTintColor = appearance.tabBarUnselectedTintColor
  }
}
