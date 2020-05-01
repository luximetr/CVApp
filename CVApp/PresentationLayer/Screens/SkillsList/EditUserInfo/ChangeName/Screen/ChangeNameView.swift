//
//  ChangeNameView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  let inputField = UITextField()
  let continueButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
    setupInputField()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      inputField,
      continueButton
    ])
    autoLayoutInputField()
    autoLayoutContinueButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setInputField(appearance: appearance)
    setContinueButton(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup navigationBarView
  
  private func setupNavigationBarView() {
    navigationBarView.leftButton.imageView.image = AssetsFactory.left_arrow
  }
  
  // MARK: - Setup inputField
  
  private func setupInputField() {
    inputField.autocorrectionType = .no
    inputField.autocapitalizationType = .none
    inputField.layer.cornerRadius = 7
  }
  
  private func setInputField(appearance: Appearance) {
    inputField.backgroundColor = appearance.background.secondary
    inputField.textColor = appearance.text.primary
    inputField.tintColor = appearance.action.primary.background
    inputField.keyboardAppearance = appearance.keyboard.style
  }
  
  private func autoLayoutInputField() {
    inputField.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(navigationBarView.snp.bottom).offset(24)
      make.height.equalTo(40)
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
      make.leading.trailing.equalTo(inputField)
      make.top.equalTo(inputField.snp.bottom).offset(24)
      make.height.equalTo(44)
    }
  }
}
