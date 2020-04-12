//
//  AuthOTPInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthOTPInputVCOutput: class {
  func didTapOnContinue()
}

class AuthOTPInputVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: AuthOTPInputView
  
  // MARK: - Dependencies
  
  var output: AuthOTPInputVCOutput?
  
  // MARK: - Data
  
  private let phoneNumber: String
  
  // MARK: - Life cycle
  
  init(view: AuthOTPInputView, phoneNumber: String) {
    selfView = view
    self.phoneNumber = phoneNumber
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
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    navigationItem.title = "OTP"
    selfView.continueButton.title = "Continue"
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    output?.didTapOnContinue()
  }
}
