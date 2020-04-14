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
  private let currentUserService: CurrentUserService
  
  init(window: UIWindow, servicesFactory: ServicesFactory) {
    self.window = window
    self.servicesFactory = servicesFactory
    self.currentUserService = servicesFactory.createCurrentUserService()
  }
  
  func showFirstScreen() {
    if let user = currentUserService.getCurrentUser() {
      print(user)
      showMainScreen()
    } else {
      showAuth()
    }
  }
  
  private func showAuth() {
    let coordinator = AuthPhoneInputCoordinator(servicesFactory: servicesFactory)
    coordinator.showAuthPhoneInputScreen(window: window)
  }
  
  private func showMainScreen() {
    let coordinator = MainTabBarCoordinator(servicesFactory: servicesFactory)
    coordinator.showTabBar(window: window)
  }
}
