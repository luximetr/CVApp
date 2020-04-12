//
//  SettingsCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsCoordinator: SettingsPresenterOutput {
  
  // MARK: - Create screen
  
  func createSettingsScreen() -> UIViewController {
    return SettingsScreenConfigurator().getConfiguredScreen(output: self)
  }
  
  // MARK: - SettingsPresenterOutput
  
  func didTapOnChangeName(sourceVC: UIViewController) {
    ChangeNameCoordinator().showChangeNameScreen(sourceVC: sourceVC)
  }
}
