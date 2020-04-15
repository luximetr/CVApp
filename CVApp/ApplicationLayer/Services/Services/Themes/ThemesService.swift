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
  private let defaultTheme: Theme
  private var currentTheme: Theme?
  private let currentThemeChangedNotifier: CurrentThemeChangedNotifier
  private let currentThemeCacheWorker: CurrentThemeCacheWorker
  
  // MARK: - Life cycle
  
  init(currentThemeChangedNotifier: CurrentThemeChangedNotifier,
       currentThemeCacheWorker: CurrentThemeCacheWorker) {
    themesFactory = ThemesFactory()
    defaultTheme = themesFactory.createLightTheme()
    self.currentThemeChangedNotifier = currentThemeChangedNotifier
    self.currentThemeCacheWorker = currentThemeCacheWorker
  }
  
  // MARK: - Get theme
  
  func getCurrentTheme() -> Theme {
    return
      currentTheme ??
      fetchCachedCurrentTheme() ??
      defaultTheme
  }
  
  private func fetchCachedCurrentTheme() -> Theme? {
    guard let currentThemeType = currentThemeCacheWorker.fetchCurrentThemeType() else { return nil }
    let list = getThemesList()
    return list.first(where: { $0.type == currentThemeType })
  }
  
  func getThemesList() -> [Theme] {
    return themesFactory.createThemesList()
  }
  
  func changeCurrentTheme(_ theme: Theme) {
    currentTheme = theme
    currentThemeCacheWorker.saveCurrentTheme(theme.type)
    currentThemeChangedNotifier.notifyCurrentThemeChanged(theme)
  }
  
  func addCurrentThemeChangedObserver(_ observer: CurrentThemeChangedObserver) {
    currentThemeChangedNotifier.addObserver(observer)
  }
}
