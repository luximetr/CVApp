//
//  AppearanceService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

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
  
  private func getAppearance(theme: Theme) -> Appearance {
    switch theme.type {
    case .dark: return getDarkAppearance()
    case .light: return getLightAppearance()
    case .glamour: return getGlamourAppearance()
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
  
  private func getGlamourAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .color(red: 174, green: 47, blue: 117),
      secondaryBackgroundColor: .color(red: 174, green: 47, blue: 117),
      statusBarStyle: .light,
      navigationBackgroundColor: .color(red: 164, green: 37, blue: 107),
      navigationTintColor: .color(red: 247, green: 209, blue: 229),
      navigationShadowColor: .color(red: 144, green: 17, blue: 87),
      tabBarBackgroundColor: .color(red: 164, green: 37, blue: 107),
      tabBarSelectedTintColor: .color(red: 242, green: 195, blue: 109),
      tabBarUnselectedTintColor: .color(red: 202, green: 155, blue: 69),
      primaryTextColor: .color(red: 247, green: 209, blue: 229),
      secondaryTextColor: .color(red: 167, green: 149, blue: 169),
      disruptiveTextColor: .color(red: 255, green: 85, blue: 85),
      primaryActionColor: .color(red: 183, green: 53, blue: 115),
      primaryActionTitleColor: .white,
      dividerBackgroundColor: .white)
  }
  
  // MARK: - CurrentThemeChangedObserver
  
  func currentThemeChanged(_ theme: Theme) {
    let appearance = getAppearance(theme: theme)
    currentAppearanceChangedNotifier.notifyCurrentAppearanceChanged(appearance)
  }
}
