//
//  ThemesService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ThemesService {
  
  // MARK: - Dependencies
  
  private let themesFactory: ThemesFactory
  private let currentThemeChangedNotifier: CurrentThemeChangedNotifier
  private let currentThemeCacheWorker: CurrentThemeCacheWorker
  
  // MARK: - Data
  
  private lazy var currentTheme = self.fetchCurrentTheme()
  
  // MARK: - Life cycle
  
  init(currentThemeChangedNotifier: CurrentThemeChangedNotifier,
       currentThemeCacheWorker: CurrentThemeCacheWorker) {
    themesFactory = ThemesFactory()
    self.currentThemeChangedNotifier = currentThemeChangedNotifier
    self.currentThemeCacheWorker = currentThemeCacheWorker
  }
  
  // MARK: - Theme handling
  
  func getCurrentTheme() -> Theme {
    return currentTheme
  }
  
  private func fetchCurrentTheme() -> Theme {
    return fetchCachedCurrentTheme() ?? getDefaultTheme()
  }
  
  private func getDefaultTheme() -> Theme {
    return themesFactory.createLightTheme()
  }
  
  private func fetchCachedCurrentTheme() -> Theme? {
    guard let currentThemeType = currentThemeCacheWorker.fetchCurrentThemeType() else { return nil }
    return themesFactory.createTheme(type: currentThemeType)
  }
  
  func getThemesList() -> [Theme] {
    return themesFactory.createThemesList()
  }
  
  func changeCurrentTheme(_ theme: Theme) {
    currentTheme = theme
    currentThemeCacheWorker.saveCurrentTheme(type: theme.type)
    currentThemeChangedNotifier.notifyCurrentThemeChanged(theme)
  }
  
  func addCurrentThemeChangedObserver(_ observer: CurrentThemeChangedObserver) {
    currentThemeChangedNotifier.addObserver(observer)
  }
}
