//
//  AuthOTPInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthOTPInputVCOutput: class {
  func otpConfirmed(sourceVC: UIViewController, user: User)
}

class AuthOTPInputVC: ScreenController, OverScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: AuthOTPInputView
  
  // MARK: - Dependencies
  
  var output: AuthOTPInputVCOutput?
  var confirmOTPService: AuthConfirmOTPService!
  
  // MARK: - Data
  
  private let phoneNumber: String
  
  // MARK: - Life cycle
  
  init(view: AuthOTPInputView, phoneNumber: String) {
    selfView = view
    self.phoneNumber = phoneNumber
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    selfView.continueButton.addTarget(self, action: #selector(didTapOnContinue), for: .touchUpInside)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "confirm_otp.title")
    selfView.continueButton.title = getLocalizedString(key: "confirm_otp.continue.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    guard let code = selfView.otpInputField.text, !code.isEmpty else { return }
    confirmOTP(code: code)
  }
  
  // MARK: - Confirm OTP
  
  private func confirmOTP(code: String) {
    showOverScreenLoader()
    confirmOTPService.confirmOTP(code: code, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let user):
        strongSelf.output?.otpConfirmed(sourceVC: strongSelf, user: user)
      case .failure(let error):
        print(error.message)
      }
    })
  }
}
