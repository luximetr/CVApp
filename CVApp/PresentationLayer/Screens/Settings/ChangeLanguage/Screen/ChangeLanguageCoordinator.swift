//
//  ChangeLanguageCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeLanguageCoordinator: ChangeLanguageVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  private func createChangeLanguageScreen() -> UIViewController {
    let view = ChangeLanguageView()
    let vc = ChangeLanguageVC(view: view)
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.languagesService = servicesFactory.createLanguagesService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showChangeLanguageScreen(sourceVC: UIViewController) {
    let vc = createChangeLanguageScreen()
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - ChangeLanguageVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
