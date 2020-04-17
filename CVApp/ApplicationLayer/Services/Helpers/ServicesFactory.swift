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
  
  private var appearanceService: AppearanceService?
  
  func createAppearanceService() -> AppearanceService {
    if let appearanceService = appearanceService {
      return appearanceService
    } else {
      let service = AppearanceService(
      themesService: createThemesService(),
      currentAppearanceChangedNotifier: createCurrentAppearanceChangedNotifier())
      appearanceService = service
      return service
    }
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
  
  private var languagesService: LanguagesService?
  
  func createLanguagesService() -> LanguagesService {
    if let languagesService = languagesService {
      return languagesService
    } else {
      let service = LanguagesService(
      currentLanguageChangedNotifier: createCurrentLanguageChangedNotifier(),
      currentLanguageCacheWorker: cacheWorkersFactory.createCurrentLanguageWorker())
      languagesService = service
      return service
    }
  }
  
  private var currentLanguageChangedNotifier: CurrentLanguageChangedNotifier?
  
  private func createCurrentLanguageChangedNotifier() -> CurrentLanguageChangedNotifier {
    if let notifier = currentLanguageChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentLanguageChangedNotifier()
      currentLanguageChangedNotifier = notifier
      return notifier
    }
  }
  
  func createStringsLocalizeService() -> StringsLocalizeService {
    return StringsLocalizeService(
      languagesService: createLanguagesService())
  }
  
}
