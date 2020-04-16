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
  
  func getLightAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .white,
      secondaryBackgroundColor: .color(red: 235, green: 235, blue: 235),
      primaryTextColor: .black,
      secondaryTextColor: .lightGray,
      primaryActionColor: .blue,
      primaryActionTitleColor: .white,
      dividerBackgroundColor: .lightGray)
  }
  
  func getDarkAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .black,
      secondaryBackgroundColor: .gray,
      primaryTextColor: .white,
      secondaryTextColor: .color(red: 235, green: 235, blue: 235),
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
