//
//  FirstScreenService.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class FirstScreenService {
  
  // MARK: - Dependencies
  
  private let window: UIWindow
  private let servicesFactory: ServicesFactory

  // MARK: - Life cycle
  
  init(window: UIWindow, servicesFactory: ServicesFactory) {
    self.window = window
    self.servicesFactory = servicesFactory
  }
  
  func showFirstScreen() {
    let coordinator = SkillsListCoordinator()
    coordinator.showSkillsList(window: window)
  }
}
