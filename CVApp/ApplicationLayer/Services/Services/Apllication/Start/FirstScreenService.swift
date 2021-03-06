//
//  FirstScreenService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class FirstScreenService {
  
  // MARK: - Dependencies
  
  private let window: UIWindow
  private let servicesFactory: ServicesFactory
  private let currentUserService: CurrentUserService
  
  // MARK: - Life cycle
  
  init(window: UIWindow, servicesFactory: ServicesFactory) {
    self.window = window
    self.servicesFactory = servicesFactory
    self.currentUserService = servicesFactory.createCurrentUserService()
  }
  
  // MARK: - Routing
  
  func showFirstScreen() {
    if currentUserService.getAuthToken() != nil {
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
