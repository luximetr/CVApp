//
//  ChangeNameCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameCoordinator {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func showChangeNameScreen(sourceVC: UIViewController) {
    let view = InitView()
    let vc = ChangeNameVC(screenView: view)
    vc.appearanceService = servicesFactory.createAppearanceService()
    sourceVC.showScreen(vc, animation: .push)
  }
}
