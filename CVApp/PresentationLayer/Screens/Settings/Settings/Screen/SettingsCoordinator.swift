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
    let vc = SettingsVC(
      view: view,
      currentApperanceService: servicesFactory.createAppearanceService())
    view.delegate = vc
    view.appearanceService = servicesFactory.createAppearanceService()
    vc.output = self
    vc.signOutService = servicesFactory.createSignOutService()
    vc.themesService = servicesFactory.createThemesService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.languagesService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "Settings")
    vc.showPopupAlertService = servicesFactory.createShowPopupAlertService()
    return vc
  }
  
  // MARK: - SettingsVCOutput
  
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
