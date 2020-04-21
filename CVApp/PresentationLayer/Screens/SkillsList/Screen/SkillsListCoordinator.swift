//
//  SkillsListPresentation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListPresentation: SkillsListVCOutput {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func createSkillsListScreen() -> UIViewController {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view)
    vc.output = self
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.changeUserNameService = servicesFactory.createChangeUserNameService()
    vc.getCVService = servicesFactory.createGetCVService()
    return vc
  }
  
  // MARK: - SkillsListPresenterOutput
  
  
}
