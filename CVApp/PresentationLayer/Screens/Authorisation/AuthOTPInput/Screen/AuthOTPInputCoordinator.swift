//
//  AuthOTPInputCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthOTPInputCoordinator: AuthOTPInputVCOutput {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  func showAuthOTPInputScreen(sourceVC: UIViewController, phoneNumber: String) {
    let vc = createAuthOTPInputScreen(phoneNumber: phoneNumber)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  private func createAuthOTPInputScreen(phoneNumber: String) -> UIViewController {
    let view = AuthOTPInputView()
    let vc = AuthOTPInputVC(view: view, phoneNumber: phoneNumber)
    vc.confirmOTPService = servicesFactory.createAuthConfirmOTPService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "AuthOTPInput")
    vc.output = self
    return vc
  }
  
  // MARK: - AuthOTPInputVCOutput
  
  func didTapOnBack(sourceVC: UIViewController) {
    sourceVC.closeScreen(animation: .pop)
  }
  
  func otpConfirmed(sourceVC: UIViewController) {
    let coordinator = MainTabBarCoordinator(servicesFactory: servicesFactory)
    coordinator.showTabBar(sourceVC: sourceVC)
  }
  
}
