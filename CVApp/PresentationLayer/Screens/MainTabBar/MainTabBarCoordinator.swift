//
//  MainTabBarCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class MainTabBarCoordinator {
  
  func showTabBar(window: UIWindow) {
    let tabBarController = MainTabBarController()
    tabBarController.coordinator = self
    tabBarController.viewControllers = createTabs()
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }
  
  private func createTabs() -> [UIViewController] {
    return [
      createSkillsTab(),
      createSettingsTab()
    ]
  }
  
  private func createSkillsTab() -> UIViewController {
    let navigationController = SwipeNavigationController()
    let vc = SkillsListCoordinator().createSkillsListScreen()
    navigationController.viewControllers = [vc]
    navigationController.tabBarItem.title = "Skills"
    return navigationController
  }
  
  private func createSettingsTab() -> UIViewController {
    let navigationController = SwipeNavigationController()
    let vc = SettingsCoordinator().createSettingsScreen()
    navigationController.viewControllers = [vc]
    navigationController.tabBarItem.title = "Settings"
    return navigationController
  }
}
