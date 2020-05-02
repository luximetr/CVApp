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
  
  private func createChangeNameScreen(cvId: CVIdType, name: String) -> UIViewController {
    let view = ChangeNameView()
    let vc = ChangeNameVC(
      view: view,
      cvId: cvId,
      name: name,
      currentAppearanceService: servicesFactory.createAppearanceService())
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "ChangeName")
    vc.changeUserNameService = servicesFactory.createChangeCVUserNameService()
    vc.showErrorAlertService = servicesFactory.createShowErrorAlertService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showChangeNameScreen(sourceVC: UIViewController, cvId: CVIdType, name: String) {
    let vc = createChangeNameScreen(cvId: cvId, name: name)
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
