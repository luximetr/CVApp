//
//  SettingsCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsCoordinator: SettingsVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  func createSettingsScreen() -> UIViewController {
    let view = SettingsView()
    let vc = SettingsVC(view: view)
    vc.output = self
    vc.signOutService = servicesFactory.createSignOutService()
    return vc
  }
  
  // MARK: - SettingsVCOutput
  
  func didTapOnChangeName(sourceVC: UIViewController) {
    ChangeNameCoordinator().showChangeNameScreen(sourceVC: sourceVC)
  }
  
  func didSignOut(sourceVC: UIViewController) {
    let coordinator = AuthPhoneInputCoordinator(servicesFactory: servicesFactory)
    coordinator.showAuthPhoneInputScreen(sourceVC: sourceVC)
  }
  
}
