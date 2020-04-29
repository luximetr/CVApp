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
  let hintLabel = UILabel()
  let showHintButton = UIButton()
  let continueButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
    setupOTPInputField()
    setupHintLabel()
    setupShowHintButton()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(hintLabel)
    addSubview(showHintButton)
    addSubview(otpInputField)
    addSubview(continueButton)
    autoLayoutShowHintButton()
    autoLayoutHintLabel()
    autoLayoutOTPInputField()
    autoLayoutContinueButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setShowHintButton(appearance: appearance)
    setHintLabel(appearance: appearance)
    setOTPInputField(appearance: appearance)
    setContinueButton(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup navigationBarView
  
  private func setupNavigationBarView() {
    navigationBarView.leftButton.image = AssetsFactory.left_arrow
  }
  
  // MARK: - Setup otpInputField
  
  private func setupOTPInputField() {
    otpInputField.layer.cornerRadius = 7
    otpInputField.keyboardType = .asciiCapableNumberPad
    otpInputField.autocapitalizationType = .none
    otpInputField.autocorrectionType = .no
  }
  
  private func setOTPInputField(appearance: Appearance) {
    otpInputField.backgroundColor = appearance.background.secondary
    otpInputField.textColor = appearance.text.primary
    otpInputField.tintColor = appearance.action.primary.background
  }
  
  private func autoLayoutOTPInputField() {
    otpInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(navigationBarView.snp.bottom).offset(24)
      make.height.equalTo(40)
    }
  }
  
  // MARK: - Setup hintLabel
  
  private func setupHintLabel() {
    hintLabel.font = .font(ofSize: 13)
    hintLabel.alpha = 0
  }
  
  private func setHintLabel(appearance: Appearance) {
    hintLabel.textColor = appearance.text.secondary
  }
  
  private func autoLayoutHintLabel() {
    hintLabel.snp.makeConstraints { make in
      make.edges.equalTo(showHintButton)
    }
  }
  
  func showHint() {
    showHintButton.alpha = 0
    hintLabel.alpha = 1
  }
  
  // MARK: - Setup showHintButton
  
  private func setupShowHintButton() {
    showHintButton.titleLabel?.textAlignment = .left
    showHintButton.titleLabel?.font = .font(ofSize: 13)
  }
  
  private func setShowHintButton(appearance: Appearance) {
    showHintButton.titleColor = appearance.text.secondary
  }
  
  private func autoLayoutShowHintButton() {
    showHintButton.snp.makeConstraints { make in
      make.leading.equalTo(otpInputField)
      make.bottom.equalTo(otpInputField.snp.top).offset(4)
    }
  }
  
  // MARK: - Setup continueButton
  
  private func setupContinueButton() {
    continueButton.layer.cornerRadius = 7
  }
  
  private func setContinueButton(appearance: Appearance) {
    continueButton.backgroundColor = appearance.action.primary.background
    continueButton.titleColor = appearance.action.primary.title
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(otpInputField)
      make.top.equalTo(otpInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
