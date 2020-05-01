//
//  MainTabBarController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, CurrentAppearanceChangedObserver, CurrentLanguageChangedObserver {
  
  // MARK: - Dependencies
  
  var coordinator: MainTabBarCoordinator!
  var currentAppearanceService: AppearanceService? {
    didSet { currentAppearanceService?.addCurrentAppearanceChanged(observer: self) }
  }
  var currentLanguageService: LanguagesService? {
    didSet { currentLanguageService?.addCurrentLanguageChanged(observer: self) }
  }
  var stringsLocalizeService: StringsLocalizeService?
  
  // MARK: - Setup
  
  func setup() {
    tabBar.isTranslucent = false
    setupAppearance()
    displayTextValues()
  }
  
  // MARK: - Appearance
  // CurrentAppearanceChangedObserver
  
  func currentAppearanceChanged(_ appearance: Appearance) {
    setSelf(appearance: appearance)
  }
  
  private func setupAppearance() {
    guard let appearance = currentAppearanceService?.getCurrentAppearance() else { return }
    setSelf(appearance: appearance)
  }
  
  private func setSelf(appearance: Appearance) {
    tabBar.tintColor = appearance.tabBar.selectedTint
    tabBar.unselectedItemTintColor = appearance.tabBar.unselectedTint
    tabBar.backgroundColor = appearance.tabBar.background
    tabBar.shadowColor = appearance.tabBar.shadow
  }
  
  // MARK: - View controllers
  
  override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
    displayTextValues()
  }
  
  // MARK: - Localisation
  // CurrentLanguageChangedObserver
  
  func currentLanguageChanged(_ language: Language) {
    displayTextValues()
  }
  
  func displayTextValues() {
    if let tab1 = viewControllers?.getElement(at: 0) {
      tab1.tabBarItem.image = AssetsFactory.cv
      tab1.tabBarItem.imageInsets = getImageInsets()
      tab1.tabBarItem.title = getLocalizedString(key: "main_tab_bar.skills.title")
    }
    if let tab2 = viewControllers?.getElement(at: 1) {
      tab2.tabBarItem.image = AssetsFactory.network
      tab2.tabBarItem.imageInsets = getImageInsets()
      tab2.tabBarItem.title = getLocalizedString(key: "main_tab_bar.network.title")
    }
    if let tab3 = viewControllers?.getElement(at: 2) {
      tab3.tabBarItem.image = AssetsFactory.settings
      tab3.tabBarItem.imageInsets = getImageInsets()
      tab3.tabBarItem.title = getLocalizedString(key: "main_tab_bar.settings.title")
    }
  }
  
  private func getImageInsets() -> UIEdgeInsets {
    return .init(top: 3, left: 2, bottom: 2, right: 2)
  }
  
  func getLocalizedString(key: String) -> String {
    return stringsLocalizeService?.getLocalizedString(key: key) ?? key
  }
}
