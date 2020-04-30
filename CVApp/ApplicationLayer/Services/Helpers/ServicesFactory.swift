//
//  ServicesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ServicesFactory {
  
  // MARK: - Dependencies
  
  private let webAPIWorkersFactory: WebAPIWorkersFactory
  private let cacheWorkersFactory: CacheWorkersFactory
  private let notifiersFactory: NotifiersFactory
  private let application: UIApplication
  private let referenceStorage: ReferenceStorage
  
  // MARK: - Life cycle
  
  init(application: UIApplication,
       userDefaultsStorage: UserDefaultsStorage,
       coreDataStorage: CoreDataStorage,
       referenceStorage: ReferenceStorage,
       session: URLSession) {
    self.webAPIWorkersFactory = WebAPIWorkersFactory(
      session: session)
    self.cacheWorkersFactory = CacheWorkersFactory(
      userDefaultsStorage: userDefaultsStorage,
      coreDataStorage: coreDataStorage,
      referenceStorage: referenceStorage)
    self.notifiersFactory = NotifiersFactory(
      referenceStorage: referenceStorage)
    self.application = application
    self.referenceStorage = referenceStorage
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
  
  // MARK: - CV
  
  func createGetCVService() -> GetCVService {
    return GetCVService(
      currentUserService: createCurrentUserService(),
      getCVWebAPIWorker: webAPIWorkersFactory.getUserCVWorker(),
      cvCacheWorker: cacheWorkersFactory.createCurrentUserCVWorker())
  }
  
  func createGetNetworkCVsService() -> GetNetworkCVsService {
    return GetNetworkCVsService(
      getNetworkCVsWebAPIWorker: webAPIWorkersFactory.getNetworkCVsWorker(),
      currentUserService: createCurrentUserService(),
      cvCacheWorker: cacheWorkersFactory.createNetworkCVWorker())
  }
  
  func createChangeCVAvatarService() -> ChangeCVAvatarService {
    return ChangeCVAvatarService(
      currentUserService: createCurrentUserService(),
      changeAvatarWebAPIWorker: webAPIWorkersFactory.createChangeCVAvatarWorker(),
      currentUserAvatarChangedNotifier: notifiersFactory.createCVUserAvatarChangedNotifier(),
      cvCacheWorker: cacheWorkersFactory.createCurrentUserCVWorker())
  }
  
  func createChangeUserNameService() -> ChangeUserNameService {
    return ChangeUserNameService(
      currentUserService: createCurrentUserService(),
      changeUserNameWebAPIWorker: webAPIWorkersFactory.createChangeUserNameWorker(),
      currentUserNameChangedNotifier: notifiersFactory.createCVUserNameChangedNotifier())
  }
  
  func createChangeUserRoleService() -> ChangeUserRoleService {
    return ChangeUserRoleService(
      currentUserService: createCurrentUserService(),
      changeRoleWebAPIWorker: webAPIWorkersFactory.createChangeUserRoleWorker(),
      currentUserRoleChangedNotifier: notifiersFactory.createCVUserRoleChangedNotifier())
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
  
  // MARK: - Theme
  
  func createThemesService() -> ThemesService {
    let key = "themesService"
    if let service = referenceStorage.getObject(key) as? ThemesService {
      return service
    } else {
      let service = ThemesService(
        currentThemeChangedNotifier: notifiersFactory.createCurrentThemeChangedNotifier(),
        currentThemeCacheWorker: cacheWorkersFactory.createCurrentThemeWorker())
      referenceStorage.storeObject(key, object: service)
      return service
    }
  }
  
  // MARK: - Links
  
  func createOpenLinkExternallyService() -> OpenLinkExternallyService {
    return OpenLinkExternallyService(application: application)
  }
  
  func createCallPhoneService() -> CallPhoneService {
    return CallPhoneService(
      openLinkService: createOpenLinkExternallyService())
  }
  
  func createSendMailService() -> SendMailService {
    return SendMailService(
      openLinkService: createOpenLinkExternallyService())
  }
  
  // MARK: - Appearance
  
  func createAppearanceService() -> AppearanceService {
    let key = "appearanceService"
    if let service = referenceStorage.getObject(key) as? AppearanceService {
      return service
    } else {
      let service = AppearanceService(
        themesService: createThemesService(),
        currentAppearanceChangedNotifier: notifiersFactory.createCurrentAppearanceChangedNotifier(),
        progressHUDAppearanceService: createProgressHUDAppearanceService())
      referenceStorage.storeObject(key, object: service)
      return service
    }
  }
  
  private func createProgressHUDAppearanceService() -> ProgressHUDAppearanceService {
    return ProgressHUDAppearanceService()
  }
  
  // MARK: - Languages
  
  func createLanguagesService() -> LanguagesService {
    let key = "languagesService"
    if let service = referenceStorage.getObject(key) as? LanguagesService {
      return service
    } else {
      let service = LanguagesService(
        currentLanguageChangedNotifier: notifiersFactory.createCurrentLanguageChangedNotifier(),
        currentLanguageCacheWorker: cacheWorkersFactory.createCurrentLanguageWorker())
      referenceStorage.storeObject(key, object: service)
      return service
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
