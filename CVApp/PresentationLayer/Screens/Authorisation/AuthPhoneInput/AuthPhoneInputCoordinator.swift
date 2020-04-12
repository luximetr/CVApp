//
//  AuthPhoneInputCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthPhoneInputCoordinator: AuthPhoneInputVCOutput {
  
  let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func showAuthPhoneInputScreen(window: UIWindow) {
    let navigationController = SwipeNavigationController()
    let vc = createAuthPhoneInputScreen()
    navigationController.viewControllers = [vc]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  private func createAuthPhoneInputScreen() -> UIViewController {
    let view = AuthPhoneInputView()
    let vc = AuthPhoneInputVC(view: view)
    vc.output = self
    vc.requestOTPService = servicesFactory.createRequestOTPService()
    return vc
  }
  
  // MARK: - AuthPhoneInputVCOutput
  
  func otpRequested(sourceVC: UIViewController, phoneNumber: String) {
    let coordinator = AuthOTPInputCoordinator()
    coordinator.showAuthOTPInputScreen(sourceVC: sourceVC, phoneNumber: phoneNumber)
  }
}