//
//  SettingsCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsCoordinator: SettingsVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  func createSettingsScreen() -> UIViewController {
    let view = SettingsView()
    let vc = SettingsVC(view: view)
    vc.output = self
    vc.signOutService = servicesFactory.createSignOutService()
    vc.themesService = servicesFactory.createThemesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.languagesService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.remoteImageSetService = servicesFactory.createRemoteImageSetService()
    vc.uploadImageService = servicesFactory.createUploadFileService()
    return vc
  }
  
  // MARK: - SettingsVCOutput
  
  func didTapOnChangeAvatar(in vc: UIViewController) {
    let coordinator = ChangeAvatarCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeAvatarScreen(sourceVC: vc)
  }
  
  func didTapOnChangeName(in vc: UIViewController) {
    let coordinator = ChangeNameCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeNameScreen(sourceVC: vc)
  }
  
  func didTapOnChangeLanguage(in vc: UIViewController) {
    let coordinator = ChangeLanguageCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeLanguageScreen(sourceVC: vc)
  }
  
  func didTapOnChangeTheme(in vc: UIViewController) {
    let coordinator = ChangeThemeCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeThemeScreen(sourceVC: vc)
  }
  
  func didSignOut(in vc: UIViewController) {
    let coordinator = AuthPhoneInputCoordinator(servicesFactory: servicesFactory)
    coordinator.showAuthPhoneInputScreen(sourceVC: vc)
  }
  
}
