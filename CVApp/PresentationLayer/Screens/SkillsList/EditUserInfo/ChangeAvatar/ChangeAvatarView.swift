//
//  ChangeAvatarView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeAvatarView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  let avatarView = AvatarView()
  let continueButton = UIButton()
  let changeAvatarButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
    setupAvatarView()
    setupContinueButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(avatarView)
    addSubview(changeAvatarButton)
    addSubview(continueButton)
    autoLayoutAvatarView()
    autoLayoutChangeAvatarButton()
    autoLayoutContinueButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setAvatarView(appearance: appearance)
    setChangeAvatarButton(appearance: appearance)
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
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func setAvatarView(appearance: Appearance) {
    avatarView.setAppearance(appearance)
  }
  
  private func autoLayoutAvatarView() {
    let side: CGFloat = 280
    avatarView.snp.makeConstraints { make in
      make.width.height.equalTo(side)
      make.centerX.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom).offset(24)
    }
    avatarView.layer.cornerRadius = side / 2
  }
  
  // MARK: - Setup ContinueButton
  
  private func setupContinueButton() {
    continueButton.layer.cornerRadius = 7
  }
  
  private func setContinueButton(appearance: Appearance) {
    continueButton.backgroundColor = appearance.action.primary.background
    continueButton.titleColor = appearance.action.primary.title
  }
  
  private func autoLayoutContinueButton() {
    continueButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(changeAvatarButton)
      make.height.equalTo(44)
      make.top.equalTo(avatarView.snp.bottom).offset(24)
    }
  }
  
  // MARK: - Setup changeAvatarButton
  
  private func setChangeAvatarButton(appearance: Appearance) {
    changeAvatarButton.backgroundColor = appearance.action.secondary.background
    changeAvatarButton.titleColor = appearance.action.secondary.title
  }
  
  private func autoLayoutChangeAvatarButton() {
    changeAvatarButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(continueButton.snp.bottom).offset(10)
      make.height.equalTo(34)
    }
  }
}
