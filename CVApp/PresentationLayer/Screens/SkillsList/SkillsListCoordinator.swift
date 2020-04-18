//
//  SkillsListCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListCoordinator: SkillsListPresenterOutput {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func createSkillsListScreen() -> UIViewController {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view)
    let presenter = SkillsListPresenter()
    vc.output = presenter
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    presenter.screen = vc
    presenter.output = self
    return vc
  }
  
  // MARK: - SkillsListPresenterOutput
  
  
}
