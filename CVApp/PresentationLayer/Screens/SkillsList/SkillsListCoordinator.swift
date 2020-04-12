//
//  SkillsListCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListCoordinator: SkillsListPresenterOutput {
  
  func createSkillsListScreen() -> UIViewController {
    return SkillsListScreenConfigurator().createScreen(output: self)
  }
  
  // MARK: - SkillsListPresenterOutput
  
  
}
