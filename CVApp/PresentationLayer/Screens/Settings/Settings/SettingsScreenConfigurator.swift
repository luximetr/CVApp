//
//  SettingsScreenConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsScreenConfigurator {
  
  func getConfiguredScreen(output: SettingsPresenterOutput) -> UIViewController {
    let vc = SettingsVC()
    let presenter = SettingsPresenter()
    vc.output = presenter
    presenter.screen = vc
    presenter.output = output
    return vc
  }
}
