//
//  AuthPhoneInputView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthPhoneInputView: InitView {
  
  // MARK: - UI elements
  
  let phoneInputField = UITextField()
  let continueButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupPhoneInputField()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(phoneInputField)
    addSubview(continueButton)
    autoLayoutPhoneInputField()
    autoLayoutContinueButton()
  }
  
  // MARK: - Setup phoneInputField
  
  private func setupPhoneInputField() {
    phoneInputField.keyboardType = .namePhonePad
    phoneInputField.layer.borderColor = UIColor.black.cgColor
    phoneInputField.layer.borderWidth = 1
  }
  
  private func autoLayoutPhoneInputField() {
    phoneInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(self.safeArea.top).offset(24)
      make.height.equalTo(40)
    }
  }
  
  // MARK: - Setup continueButton
  
  private func setupContinueButton() {
    continueButton.backgroundColor = .blue
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(phoneInputField)
      make.top.equalTo(phoneInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
