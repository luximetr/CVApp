//
//  AppearanceService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AppearanceService: CurrentThemeChangedObserver {
  
  // MARK: - Services
  
  private let themesService: ThemesService
  private let currentAppearanceChangedNotifier: CurrentAppearanceChangedNotifier
  
  // MARK: - Life cycle
  
  init(themesService: ThemesService,
       currentAppearanceChangedNotifier: CurrentAppearanceChangedNotifier) {
    self.themesService = themesService
    self.currentAppearanceChangedNotifier = currentAppearanceChangedNotifier
    themesService.addCurrentThemeChangedObserver(self)
  }
  
  // MARK: - Add observer
  
  func addCurrentAppearanceChanged(observer: CurrentAppearanceChangedObserver) {
    currentAppearanceChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Get current appearance
  
  func getCurrentAppearance() -> Appearance {
    return getAppearance(theme: themesService.getCurrentTheme())
  }
  
  func getAppearance(theme: Theme) -> Appearance {
    switch theme.type {
    case .dark: return getDarkAppearance()
    case .light: return getLightAppearance()
    case .glamour: return getLightAppearance()
    }
  }
  
  private func getLightAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .white,
      secondaryBackgroundColor: .color(red: 235, green: 235, blue: 235),
      statusBarStyle: .dark,
      navigationBackgroundColor: .white,
      navigationTintColor: .black,
      navigationShadowColor: .color(red: 170, green: 170, blue: 170),
      tabBarBackgroundColor: .white,
      tabBarSelectedTintColor: .blue,
      tabBarUnselectedTintColor: .lightGray,
      primaryTextColor: .black,
      secondaryTextColor: .lightGray,
      disruptiveTextColor: .red,
      primaryActionColor: .blue,
      primaryActionTitleColor: .white,
      dividerBackgroundColor: .lightGray)
  }
  
  private func getDarkAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .black,
      secondaryBackgroundColor: .gray,
      statusBarStyle: .light,
      navigationBackgroundColor: .black,
      navigationTintColor: .white,
      navigationShadowColor: .color(red: 25, green: 25, blue: 25),
      tabBarBackgroundColor: .black,
      tabBarSelectedTintColor: .white,
      tabBarUnselectedTintColor: .lightGray,
      primaryTextColor: .white,
      secondaryTextColor: .color(red: 235, green: 235, blue: 235),
      disruptiveTextColor: .red,
      primaryActionColor: .cyan,
      primaryActionTitleColor: .black,
      dividerBackgroundColor: .white)
  }
  
  // MARK: - CurrentThemeChangedObserver
  
  func currentThemeChanged(_ theme: Theme) {
    let appearance = getAppearance(theme: theme)
    currentAppearanceChangedNotifier.notifyCurrentAppearanceChanged(appearance)
  }
}
