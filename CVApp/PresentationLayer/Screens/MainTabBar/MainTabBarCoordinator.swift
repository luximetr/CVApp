//
//  MainTabBarCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class MainTabBarCoordinator {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func showTabBar(window: UIWindow) {
    let tabBarController = createTabBar()
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }
  
  func showTabBar(sourceVC: UIViewController) {
    let tabBarController = createTabBar()
    sourceVC.showScreen(tabBarController, animation: .present)
  }
  
  private func createTabBar() -> UITabBarController {
    let tabBarController = MainTabBarController()
    tabBarController.currentAppearanceService = servicesFactory.createAppearanceService()
    tabBarController.currentLanguageService = servicesFactory.createLanguagesService()
    tabBarController.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    tabBarController.coordinator = self
    tabBarController.setViewControllers(createTabs(), animated: false)
    tabBarController.setup()
    return tabBarController
  }
  
  private func createTabs() -> [UIViewController] {
    return [
      createSkillsTab(),
      createNetworkTab(),
      createSettingsTab()
    ]
  }
  
  private func createSkillsTab() -> UIViewController {
    let navigationController = SwipeNavigationController()
    let coordinator = SkillsListCoordinator(servicesFactory: servicesFactory)
    let vc = coordinator.createSkillsListScreen()
    navigationController.viewControllers = [vc]
    return navigationController
  }
  
  private func createNetworkTab() -> UIViewController {
    let navigationController = SwipeNavigationController()
    let coordinator = NetworkCoordinator(servicesFactory: servicesFactory)
    let vc = coordinator.createNetworkScreen()
    navigationController.viewControllers = [vc]
    return navigationController
  }
  
  private func createSettingsTab() -> UIViewController {
    let navigationController = SwipeNavigationController()
    let coordinator = SettingsCoordinator(servicesFactory: servicesFactory)
    let vc = coordinator.createSettingsScreen()
    navigationController.viewControllers = [vc]
    return navigationController
  }
}
