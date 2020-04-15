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
  private var currentTheme: Theme
  private let currentThemeChangedNotifier: CurrentThemeChangedNotifier
  
  // MARK: - Life cycle
  
  init(currentThemeChangedNotifier: CurrentThemeChangedNotifier) {
    themesFactory = ThemesFactory()
    currentTheme = themesFactory.createDarkTheme()
    self.currentThemeChangedNotifier = currentThemeChangedNotifier
  }
  
  // MARK: - Get theme
  
  func getCurrentTheme() -> Theme {
    currentTheme
  }
  
  func getThemesList() -> [Theme] {
    return themesFactory.createThemesList()
  }
  
  func changeCurrentTheme(_ theme: Theme) {
    currentTheme = theme
    currentThemeChangedNotifier.notifyCurrentThemeChanged(theme)
  }
  
  func addCurrentThemeChangedObserver(_ observer: CurrentThemeChangedObserver) {
    currentThemeChangedNotifier.addObserver(observer)
  }
}
