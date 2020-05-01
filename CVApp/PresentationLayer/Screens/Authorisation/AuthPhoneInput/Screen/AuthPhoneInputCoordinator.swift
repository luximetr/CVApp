//
//  AuthPhoneInputCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthPhoneInputCoordinator: AuthPhoneInputVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Routign
  
  func showAuthPhoneInputScreen(window: UIWindow) {
    let navigationController = SwipeNavigationController()
    let vc = createAuthPhoneInputScreen()
    navigationController.viewControllers = [vc]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func showAuthPhoneInputScreen(sourceVC: UIViewController) {
    let vc = createAuthPhoneInputScreen()
    let navigationController = SwipeNavigationController()
    navigationController.viewControllers = [vc]
    guard let window = sourceVC.view.window else { return }
    window.replaceRootVC(navigationController, animation: .transitionFlipFromRight)
  }
  
  private func createAuthPhoneInputScreen() -> UIViewController {
    let view = AuthPhoneInputView()
    let vc = AuthPhoneInputVC(view: view)
    vc.output = self
    vc.requestOTPService = servicesFactory.createAuthRequestOTPService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "AuthPhoneInput")
    vc.showErrorAlertService = servicesFactory.createShowErrorAlertService()
    return vc
  }
  
  // MARK: - AuthPhoneInputVCOutput
  
  func otpRequested(sourceVC: UIViewController, phoneNumber: String) {
    let coordinator = AuthOTPInputCoordinator(servicesFactory: servicesFactory)
    coordinator.showAuthOTPInputScreen(sourceVC: sourceVC, phoneNumber: phoneNumber)
  }
}
