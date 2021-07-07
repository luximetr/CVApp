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
    let window = UIWindow()
    self.window = window
    let service = servicesFactory.createFirstScreenService(window: window)
    service.showFirstScreen()
    
    let url = launchOptions?[.url] as? URL
    handleDeeplink(url: url)
    
    return true
  }
  
  func application(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
  {
    handleDeeplink(url: userActivity.webpageURL)
    return true
  }
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool{
    handleDeeplink(url: url)
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    handleDeeplink(url: url)
    return true
  }
  
  private func handleDeeplink(url: URL?) {
    print(url?.absoluteString)
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
