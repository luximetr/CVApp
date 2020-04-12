//
//  Application.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class Application: UIApplication, UIApplicationDelegate {
  
  // MARK: - Layers
  
  var window: UIWindow?
  private lazy var appCoordinator: AppCoordinator = {
    let window = UIWindow()
    self.window = window
    return AppCoordinator(window: window, servicesFactory: servicesFactory)
  }()
  
  // MARK: - Factories
  
  private lazy var servicesFactory: ServicesFactory = {
    return ServicesFactory()
  }()
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    appCoordinator.showFirstScreen()
    
    return true
  }
}
