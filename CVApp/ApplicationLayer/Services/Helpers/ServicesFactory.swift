//
//  ServicesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ServicesFactory {
  
  // MARK: - Dependencies
  
  private let webAPIWorkersFactory: WebAPIWorkersFactory
  private let cacheWorkersFactory: CacheWorkersFactory
  
  // MARK: - Life cycle
  
  init() {
    self.webAPIWorkersFactory = WebAPIWorkersFactory()
    self.cacheWorkersFactory = CacheWorkersFactory()
  }
  
  // MARK: - Services
  
  func createSettingsService() -> SettingsService {
    return SettingsService()
  }
  
  // MARK: - Auth
  
  func createAuthRequestOTPService() -> RequestOTPService {
    return RequestOTPService(
      webAPIWorker: webAPIWorkersFactory.createRequestOTPWorker())
  }
  
  func createAuthConfirmOTPService() -> AuthConfirmOTPService {
    return AuthConfirmOTPService(
      webAPIWorker: webAPIWorkersFactory.createAuthConfirmOTPWorker(),
      currentUserService: createCurrentUserService())
  }
  
  // MARK: - User
  
  func createCurrentUserService() -> CurrentUserService {
    return CurrentUserService(
      currentUserCacheWorker: cacheWorkersFactory.createCurrentUserWorker(),
      authTokenCacheWorker: cacheWorkersFactory.createAuthTokenWorker())
  }
  
  func createSignOutService() -> SignOutService {
    return SignOutService(
      currentUserService: createCurrentUserService())
  }
  
  // MARK: - Theme
  
  func createThemesService() -> ThemesService {
    return ThemesService(
      currentThemeChangedNotifier: createCurrentThemeChangedNotifier(),
      currentThemeCacheWorker: cacheWorkersFactory.createCurrentThemeWorker())
  }
  
  private var currentThemeChangedNotifier: CurrentThemeChangedNotifier?
  
  private func createCurrentThemeChangedNotifier() -> CurrentThemeChangedNotifier {
    if let notifier = currentThemeChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentThemeChangedNotifier()
      currentThemeChangedNotifier = notifier
      return notifier
    }
  }
  
  func createAppearanceService() -> AppearanceService {
    return AppearanceService(
      themesService: createThemesService(),
      currentAppearanceChangedNotifier: createCurrentAppearanceChangedNotifier())
  }
  
  private var currentAppearanceChangedNotifier: CurrentAppearanceChangedNotifier?
  
  private func createCurrentAppearanceChangedNotifier() -> CurrentAppearanceChangedNotifier {
    if let notifier = currentAppearanceChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentAppearanceChangedNotifier()
      currentAppearanceChangedNotifier = notifier
      return notifier
    }
  }
  
  
}
