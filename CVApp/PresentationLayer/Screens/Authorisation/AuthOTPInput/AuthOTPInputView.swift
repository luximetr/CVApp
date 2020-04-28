//
//  AuthOTPInputView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthOTPInputView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  let otpInputField = UITextField()
  let continueButton = UIButton()
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(otpInputField)
    addSubview(continueButton)
    autoLayoutOTPInputField()
    autoLayoutContinueButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setOTPInputField(appearance: appearance)
    setContinueButton(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup otpInputField
  
  private func setOTPInputField(appearance: Appearance) {
    otpInputField.backgroundColor = appearance.background.secondary
    otpInputField.textColor = appearance.text.primary
    otpInputField.tintColor = appearance.primaryActionColor
  }
  
  private func autoLayoutOTPInputField() {
    otpInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(navigationBarView.snp.bottom).offset(24)
      make.height.equalTo(40)
    }
  }
  
  // MARK: - Setup continueButton
  
  private func setContinueButton(appearance: Appearance) {
    continueButton.backgroundColor = appearance.primaryActionColor
    continueButton.titleColor = appearance.primaryActionTitleColor
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(otpInputField)
      make.top.equalTo(otpInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
