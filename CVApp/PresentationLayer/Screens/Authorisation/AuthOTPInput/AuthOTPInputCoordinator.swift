//
//  AuthOTPInputCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthOTPInputCoordinator {
  
  func showAuthOTPInputScreen(sourceVC: UIViewController, phoneNumber: String) {
    let vc = createAuthOTPInputScreen(phoneNumber: phoneNumber)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  private func createAuthOTPInputScreen(phoneNumber: String) -> UIViewController {
    let view = AuthOTPInputView()
    let vc = AuthOTPInputVC(view: view, phoneNumber: phoneNumber)
    return vc
  }
}
