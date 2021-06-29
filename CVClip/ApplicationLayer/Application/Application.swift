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
  var cvUserId: String?
  
  // MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    fetchCVUserId(launchOptions: launchOptions)
    let window = UIWindow()
    self.window = window
    let service = servicesFactory.createFirstScreenService(window: window)
    service.showFirstScreen(userId: cvUserId)
    return true
  }
  
  private func fetchCVUserId(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    let dict = launchOptions?[.userActivityDictionary] as? [String: Any]
    let userActivity = dict?["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity
    guard
      let webpageURL = userActivity?.webpageURL,
      let components = URLComponents(url: webpageURL, resolvingAgainstBaseURL: true)
    else {
      return
    }
    let userId = components.queryItems?.first(where: { $0.name == "userId" })?.value
    cvUserId = userId
  }
  
  // MARK: - Factories
  
  private lazy var servicesFactory: ServicesFactory = {
    return ServicesFactory(
      application: self)
  }()
}
