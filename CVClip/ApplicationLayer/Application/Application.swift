//
//  Application.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class Application: UIApplication, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let window = UIWindow()
    self.window = window
    let service = servicesFactory.createFirstScreenService(window: window)
    service.showFirstScreen()
    return true
  }
  
  // MARK: - Factories
  
  private lazy var servicesFactory: ServicesFactory = {
    return ServicesFactory(
      application: self)
  }()
}
