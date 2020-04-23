//
//  ChangeNameCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameCoordinator: ChangeNameVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  private func createChangeNameScreen(name: String) -> UIViewController {
    let view = ChangeNameView()
    let vc = ChangeNameVC(view: view)
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.changeUserNameService = servicesFactory.createChangeUserNameService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showChangeNameScreen(sourceVC: UIViewController, name: String) {
    let vc = createChangeNameScreen(name: name)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - ChangeNameVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
  
  func nameChangingFinished(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
