//
//  TitledNavigationBarView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TitledNavigationBarView: InitView {
  
  // MARK: - UI elements
  
  let leftButton = LeftNavigationButtonView()
  let titleLabel = UILabel()
  let rightButton = LeftNavigationButtonView()
  let shadowView = UIView()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTitleLabel()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(leftButton)
    addSubview(titleLabel)
    addSubview(rightButton)
    addSubview(shadowView)
    autoLayoutLeftButton()
    autoLayoutTitleLabel()
    autoLayoutRightButton()
    autoLayoutShadowView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setLeftButton(appearance: appearance)
    setTitleLabel(appearance: appearance)
    setRightButton(appearance: appearance)
    setShadowView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.navigation.background
  }
  
  // MARK: - Setup leftButton
  
  private func setLeftButton(appearance: Appearance) {
    leftButton.imageView.tintColor = appearance.navigation.tint
  }
  
  private func autoLayoutLeftButton() {
    leftButton.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview()
      make.width.equalTo(70)
    }
  }
  
  // MARK: - Setup titleLabel
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.navigation.tint
  }
  
  private func setupTitleLabel() {
    titleLabel.numberOfLines = 1
    titleLabel.textAlignment = .center
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(leftButton.snp.trailing).offset(15)
      make.centerY.equalToSuperview()
    }
  }
  
  // MARK: - Setup rightButton
  
  private func setRightButton(appearance: Appearance) {
    rightButton.imageView.tintColor = appearance.navigation.tint
  }
  
  private func autoLayoutRightButton() {
    rightButton.snp.makeConstraints { make in
      make.trailing.top.bottom.equalToSuperview()
      make.width.equalTo(70)
      make.leading.equalTo(titleLabel.snp.trailing).offset(15)
    }
  }
  
  // MARK: - Setup shadowView
  
  private func setShadowView(appearance: Appearance) {
    shadowView.backgroundColor = appearance.navigation.shadow
  }
  
  private func autoLayoutShadowView() {
    shadowView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
}
