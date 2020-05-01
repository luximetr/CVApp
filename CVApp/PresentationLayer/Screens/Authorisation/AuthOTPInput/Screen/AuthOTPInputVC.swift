//
//  AuthOTPInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthOTPInputVCOutput: class {
  func didTapOnBack(sourceVC: UIViewController)
  func otpConfirmed(sourceVC: UIViewController)
}

class AuthOTPInputVC: ScreenController, OverScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: AuthOTPInputView
  
  // MARK: - Dependencies
  
  var output: AuthOTPInputVCOutput?
  var confirmOTPService: AuthConfirmOTPService!
  var showErrorAlertService: ShowErrorAlertService!
  
  // MARK: - Data
  
  private let phoneNumber: String
  private let hint = "1234"
  
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    selfView.otpInputField.becomeFirstResponder()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    selfView.continueButton.addAction(self, action: #selector(didTapOnContinue))
    selfView.navigationBarView.leftButton.addAction(self, action: #selector(didTapOnBack))
    selfView.showHintButton.addAction(self, action: #selector(didTapOnShowHint))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "confirm_otp.title")
    selfView.continueButton.title = getLocalizedString(key: "confirm_otp.continue.title")
    selfView.showHintButton.title = getLocalizedString(key: "confirm_otp.show_hint.title")
    selfView.hintLabel.text = getLocalizedString(key: "confirm_otp.hint.format", hint)
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    guard let code = selfView.otpInputField.text, !code.isEmpty else { return }
    confirmOTP(code: code)
  }
  
  @objc
  private func didTapOnBack() {
    output?.didTapOnBack(sourceVC: self)
  }
  
  @objc
  private func didTapOnShowHint() {
    selfView.showHint()
  }
  
  // MARK: - Confirm OTP
  
  private func confirmOTP(code: String) {
    showOverScreenLoader()
    confirmOTPService.confirmOTP(code: code, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success:
        strongSelf.hideOverScreenLoader()
        strongSelf.output?.otpConfirmed(sourceVC: strongSelf)
      case .failure(let error):
        strongSelf.showErrorAlertService.showRepeatErrorAlert(message: error.message, in: strongSelf, onRepeat: {
          self?.confirmOTP(code: code )})
        }
    })
  }
}
