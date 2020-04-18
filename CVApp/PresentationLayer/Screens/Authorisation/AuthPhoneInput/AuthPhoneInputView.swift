//
//  AuthPhoneInputView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthPhoneInputView: ScreenNavigationBarView {
  
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
  
  // MARK: Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setPhoneInputField(appearance: appearance)
    setContinueButton(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup phoneInputField
  
  private func setupPhoneInputField() {
    phoneInputField.keyboardType = .namePhonePad
  }
  
  private func setPhoneInputField(appearance: Appearance) {
    phoneInputField.backgroundColor = appearance.secondaryBackgroundColor
    phoneInputField.textColor = appearance.primaryTextColor
  }
  
  private func autoLayoutPhoneInputField() {
    phoneInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(navigationBarView.snp.bottom).offset(24)
      make.height.equalTo(40)
    }
  }
  
  // MARK: - Setup continueButton
  
  private func setupContinueButton() {
    continueButton.backgroundColor = .blue
  }
  
  private func setContinueButton(appearance: Appearance) {
    continueButton.backgroundColor = appearance.primaryActionColor
    continueButton.titleColor = appearance.primaryActionTitleColor
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(phoneInputField)
      make.top.equalTo(phoneInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
