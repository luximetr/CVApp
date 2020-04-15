//
//  ChangeThemeCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeThemeCoordinator: ChangeThemeVCOutput {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func createChangeThemeScreen() -> UIViewController {
    let view = ChangeThemeView()
    let vc = ChangeThemeVC(view: view)
    vc.themesService = servicesFactory.createThemesService()
    vc.output = self
    return vc
  }
  
  func showChangeThemeScreen(sourceVC: UIViewController) {
    let vc = createChangeThemeScreen()
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - ChangeThemeVCOutput
  
  func themeChangingFinished(at vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
