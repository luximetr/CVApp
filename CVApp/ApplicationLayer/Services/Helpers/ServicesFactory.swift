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
      authTokenCacheWorker: cacheWorkersFactory.createAuthTokenWorker())
  }
  
  func createSignOutService() -> SignOutService {
    return SignOutService(
      currentUserService: createCurrentUserService())
  }
  
  var currentUserNameChangedNotifier: CurrentUserNameChangedNotifier?
  
  private func createCurrentUserNameChangedNotifier() -> CurrentUserNameChangedNotifier {
    if let currentUserNameChangedNotifier = currentUserNameChangedNotifier {
      return currentUserNameChangedNotifier
    } else {
      let service = CurrentUserNameChangedNotifier()
      currentUserNameChangedNotifier = service
      return service
    }
  }
  
  func createChangeUserNameService() -> ChangeUserNameService {
    return ChangeUserNameService(
      currentUserService: createCurrentUserService(),
      changeUserNameWebAPIWorker: webAPIWorkersFactory.createChangeUserNameWorker(),
      currentUserNameChangedNotifier: createCurrentUserNameChangedNotifier())
  }
  
  func createGetCVService() -> GetCVService {
    return GetCVService(
      currentUserService: createCurrentUserService(),
      getCVWebAPIWorker: webAPIWorkersFactory.getUserCVWorker(),
      cvCacheWorker: cacheWorkersFactory.createCVWorker())
  }
  
  private var currentUserAvatarChangedNotifier: CVAvatarChangedNotifier?
  
  private func createCurrentUserAvatarChangedNotifier() -> CVAvatarChangedNotifier {
    if let notifier = currentUserAvatarChangedNotifier {
      return notifier
    } else {
      let notifier = CVAvatarChangedNotifier()
      currentUserAvatarChangedNotifier = notifier
      return notifier
    }
  }
  
  func createChangeUserAvatarService() -> ChangeCVAvatarService {
    return ChangeCVAvatarService(
      currentUserService: createCurrentUserService(),
      changeAvatarWebAPIWorker: webAPIWorkersFactory.createChangeUserAvatarWorker(),
      currentUserAvatarChangedNotifier: createCurrentUserAvatarChangedNotifier(),
      cvCacheWorker: cacheWorkersFactory.createCVWorker())
  }
  
  private var currentUserRoleChangedNotifier: CurrentUserRoleChangedNotifier?
  
  private func createCurrentUserRoleChangedNotifier() -> CurrentUserRoleChangedNotifier {
    if let notifier = currentUserRoleChangedNotifier {
      return notifier
    } else {
      let notifier = CurrentUserRoleChangedNotifier()
      currentUserRoleChangedNotifier = notifier
      return notifier
    }
  }
  
  func createChangeUserRoleService() -> ChangeUserRoleService {
    return ChangeUserRoleService(
      currentUserService: createCurrentUserService(),
      changeRoleWebAPIWorker: webAPIWorkersFactory.createChangeUserRoleWorker(),
      currentUserRoleChangedNotifier: createCurrentUserRoleChangedNotifier())
  }
  
  // MARK: - Theme
  
  private var themesService: ThemesService?
  
  func createThemesService() -> ThemesService {
    if let themesService = themesService {
      return themesService
    } else {
      let service = ThemesService(
        currentThemeChangedNotifier: createCurrentThemeChangedNotifier(),
        currentThemeCacheWorker: cacheWorkersFactory.createCurrentThemeWorker())
      themesService = service
      return service
    }
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
  
  // MARK: - Appearance
  
  private var appearanceService: AppearanceService?
  
  func createAppearanceService() -> AppearanceService {
    if let appearanceService = appearanceService {
      return appearanceService
    } else {
      let service = AppearanceService(
      themesService: createThemesService(),
      currentAppearanceChangedNotifier: createCurrentAppearanceChangedNotifier(),
      progressHUDAppearanceService: createProgressHUDAppearanceService())
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
  
  private func createProgressHUDAppearanceService() -> ProgressHUDAppearanceService {
    return ProgressHUDAppearanceService()
  }
  
  // MARK: - Languages
  
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
  
  // MARK: - Files
  
  func createImageSetFromURLService() -> ImageSetFromURLService {
    return ImageSetFromURLService()
  }
  
  func createSelectImageService() -> SelectImageService {
    return SelectImageService(
      stringsLocalizeService: createStringsLocalizeService(),
      checkFileSizeService: createCheckFileSizeService())
  }
  
  private func createCheckFileSizeService() -> CheckFileSizeService {
    return CheckFileSizeService(
      stringsLocalizeService: createStringsLocalizeService())
  }
}
