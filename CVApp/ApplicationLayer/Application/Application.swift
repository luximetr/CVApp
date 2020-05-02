//
//  Application.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class Application: UIApplication, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    guard let window = window else { return true }
    let service = servicesFactory.createFirstScreenService(window: window)
    service.showFirstScreen()
    return true
  }
  
  // MARK: - Layers
  
  private lazy var userDefaultsStorage: UserDefaultsStorage = {
    return UserDefaultsStorage(storage: .standard)
  }()
  private lazy var coreDataStorage: CoreDataStorage = {
    return CoreDataStorage(storageName: "CVApp", storeURL: nil)
  }()
  private lazy var referenceStorage = ReferenceStorage()
  
  // MARK: - Factories
  
  private lazy var servicesFactory: ServicesFactory = {
    return ServicesFactory(
      application: self,
      userDefaultsStorage: userDefaultsStorage,
      coreDataStorage: coreDataStorage,
      referenceStorage: referenceStorage,
      session: .shared)
  }()
}
