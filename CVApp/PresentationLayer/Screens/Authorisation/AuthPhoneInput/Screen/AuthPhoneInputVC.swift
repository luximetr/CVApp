//
//  AuthPhoneInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthPhoneInputVCOutput {
  func otpRequested(sourceVC: UIViewController, phoneNumber: String)
}

class AuthPhoneInputVC: ScreenController, OverScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: AuthPhoneInputView
  
  // MARK: - Dependencies
  
  var output: AuthPhoneInputVCOutput?
  var requestOTPService: RequestOTPService!
  var showErrorAlertService: ShowErrorAlertService!
  
  // MARK: - Data
  
  private let hint = "test"
  
  // MARK: - Life cycle
  
  init(view: AuthPhoneInputView) {
    selfView = view
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
    selfView.continueButton.addAction(self, action: #selector(didTapOnContinue))
    selfView.showHintButton.addAction(self, action: #selector(didTapOnShowHint))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "authorisation.title")
    selfView.continueButton.title = getLocalizedString(key: "authorisation.continue.title")
    selfView.showHintButton.title = getLocalizedString(key: "authorisation.show_hint.title")
    selfView.hintLabel.text = getLocalizedString(key: "authorisation.hint.format", hint)
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    guard let phoneNumber = selfView.phoneInputField.text, !phoneNumber.isEmpty else { return }
    requestOTP(phoneNumber: phoneNumber)
  }
  
  @objc
  private func didTapOnShowHint() {
    selfView.showHint()
  }
  
  // MARK: - Request OTP
  
  private func requestOTP(phoneNumber: String) {
    showOverScreenLoader()
    requestOTPService.requestOTP(phoneNumber: phoneNumber, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.hideOverScreenLoader()
      switch result {
      case .success:
        strongSelf.output?.otpRequested(sourceVC: strongSelf, phoneNumber: phoneNumber)
      case .failure(let error):
        strongSelf.showErrorAlertService.showRepeatErrorAlert(
          message: error.message, in: strongSelf, onRepeat: {
            self?.requestOTP(phoneNumber: phoneNumber)
        })
      }
    })
  }
}
