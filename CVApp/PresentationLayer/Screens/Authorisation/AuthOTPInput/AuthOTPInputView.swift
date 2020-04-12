//
//  AuthOTPInputView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthOTPInputView: InitView {
  
  // MARK: - UI elements
  
  let otpInputField = UITextField()
  let continueButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupOTPInputField()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(otpInputField)
    addSubview(continueButton)
    autoLayoutOTPInputField()
    autoLayoutContinueButton()
  }
  
  // MARK: - Setup otpInputField
  
  private func setupOTPInputField() {
    otpInputField.layer.borderColor = UIColor.black.cgColor
    otpInputField.layer.borderWidth = 1
  }
  
  private func autoLayoutOTPInputField() {
    otpInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(safeArea.top).offset(24)
      make.height.equalTo(40)
    }
  }
  
  // MARK: - Setup continueButton
  
  private func setupContinueButton() {
    continueButton.backgroundColor = .blue
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(otpInputField)
      make.top.equalTo(otpInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
