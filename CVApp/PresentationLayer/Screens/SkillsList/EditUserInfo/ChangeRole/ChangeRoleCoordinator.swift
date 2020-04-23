//
//  ChangeRoleCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeRoleCoordinator: ChangeRoleVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  private func createChangeRoleScreen(role: String) -> UIViewController {
    let view = ChangeRoleView()
    let vc = ChangeRoleVC(view: view, role: role)
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.changeRoleService = servicesFactory.createChangeUserRoleService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showChangeRoleScreen(sourceVC: UIViewController, role: String) {
    let vc = createChangeRoleScreen(role: role)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - ChangeRoleVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
  
  func roleChangingFinished(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
