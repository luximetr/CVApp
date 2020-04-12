//
//  SkillsListScreenConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class SkillsListScreenConfigurator {
  
  func createScreen(output: SkillsListPresenterOutput) -> SkillsListVC {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view)
    let presenter = SkillsListPresenter()
    vc.output = presenter
    presenter.screen = vc
    presenter.output = output
    return vc
  }
}
