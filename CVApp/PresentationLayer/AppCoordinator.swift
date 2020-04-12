//
//  AppCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AppCoordinator {
  
  private let window: UIWindow
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.window = UIWindow()
    self.servicesFactory = servicesFactory
  }
  
  func showFirstScreen() {
    showAuth()
  }
  
  private func showAuth() {
    let coordinator = AuthPhoneInputCoordinator(servicesFactory: servicesFactory)
    coordinator.showAuthPhoneInputScreen(window: window)
  }
  
  private func showMainScreen() {
    let coordinator = MainTabBarCoordinator()
    coordinator.showTabBar(window: window)
  }
}
