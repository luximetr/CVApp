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
  
  // MARK: - Life cycle
  
  init(view: AuthPhoneInputView) {
    selfView = view
    super.init()
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
    displayTextValues()
    selfView.continueButton.addTarget(self, action: #selector(didTapOnContinue), for: .touchUpInside)
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    navigationItem.title = "Auth"
    selfView.continueButton.setTitle("Continue", for: .normal)
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    guard let phoneNumber = selfView.phoneInputField.text, !phoneNumber.isEmpty else { return }
    requestOTP(phoneNumber: phoneNumber)
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
        print(error)
      }
    })
  }
}
