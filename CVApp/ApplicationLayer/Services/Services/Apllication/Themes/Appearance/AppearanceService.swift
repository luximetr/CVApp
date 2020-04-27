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
  private let appearancesFactory: AppearancesFactory
  private let currentAppearanceChangedNotifier: CurrentAppearanceChangedNotifier
  private let progressHUDAppearanceService: ProgressHUDAppearanceService
  
  // MARK: - Life cycle
  
  init(themesService: ThemesService,
       currentAppearanceChangedNotifier: CurrentAppearanceChangedNotifier,
       progressHUDAppearanceService: ProgressHUDAppearanceService) {
    self.themesService = themesService
    appearancesFactory = AppearancesFactory()
    self.currentAppearanceChangedNotifier = currentAppearanceChangedNotifier
    self.progressHUDAppearanceService = progressHUDAppearanceService
    themesService.addCurrentThemeChangedObserver(self)
    applyCurrentAppearance()
  }
  
  // MARK: - Add observer
  
  func addCurrentAppearanceChanged(observer: CurrentAppearanceChangedObserver) {
    currentAppearanceChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Get current appearance
  
  func getCurrentAppearance() -> Appearance {
    let theme = themesService.getCurrentTheme()
    return getAppearance(theme: theme)
  }
  
  private func getAppearance(theme: Theme) -> Appearance {
    return appearancesFactory.createAppearance(theme: theme)
  }
  
  // MARK: - CurrentThemeChangedObserver
  
  func currentThemeChanged(_ theme: Theme) {
    let appearance = getAppearance(theme: theme)
    currentAppearanceChangedNotifier.notifyCurrentAppearanceChanged(appearance)
    applyCurrentAppearance()
  }
  
  // MARK: - Apply appearance
  
  private func applyCurrentAppearance() {
    let currentAppearance = getCurrentAppearance()
    progressHUDAppearanceService.applyAppearance(currentAppearance)
  }
}
