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
  let hintLabel = UILabel()
  let showHintButton = UIButton()
  let continueButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupPhoneInputField()
    setupHintLabel()
    setupShowHintButton()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(phoneInputField)
    addSubview(hintLabel)
    addSubview(showHintButton)
    addSubview(continueButton)
    autoLayoutPhoneInputField()
    autoLayoutHintLabel()
    autoLayoutShowHintButton()
    autoLayoutContinueButton()
  }
  
  // MARK: Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setPhoneInputField(appearance: appearance)
    setHintLabel(appearance: appearance)
    setShowHintButton(appearance: appearance)
    setContinueButton(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup phoneInputField
  
  private func setupPhoneInputField() {
    phoneInputField.keyboardType = .namePhonePad
    phoneInputField.layer.cornerRadius = 7
    phoneInputField.autocorrectionType = .no
    phoneInputField.autocapitalizationType = .none
  }
  
  private func setPhoneInputField(appearance: Appearance) {
    phoneInputField.backgroundColor = appearance.background.secondary
    phoneInputField.textColor = appearance.text.primary
    phoneInputField.tintColor = appearance.action.primary.background
  }
  
  private func autoLayoutPhoneInputField() {
    phoneInputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(navigationBarView.snp.bottom).offset(30)
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
      make.leading.equalTo(phoneInputField)
      make.bottom.equalTo(phoneInputField.snp.top).offset(4)
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
      make.leading.trailing.equalTo(phoneInputField)
      make.top.equalTo(phoneInputField.snp.bottom).offset(20)
      make.height.equalTo(44)
    }
  }
}
