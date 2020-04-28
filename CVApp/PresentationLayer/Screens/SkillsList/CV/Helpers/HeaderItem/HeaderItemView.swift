//
//  HeaderItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class HeaderItemView: InitView {
  
  // MARK: - UI elements
  
  private let dividerView = UIView()
  let titleLabel = UILabel()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTitleLabel()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      dividerView,
      titleLabel
    ])
    autoLayoutDividerView()
    autoLayoutTitleLabel()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setDividerView(appearance: appearance)
    setTitleLabel(appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup dividerView
  
  private func setDividerView(appearance: Appearance) {
    dividerView.backgroundColor = appearance.dividerBackgroundColor
  }
  
  private func autoLayoutDividerView() {
    dividerView.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.height.equalTo(1)
    }
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.font = .font(ofSize: 24)
    titleLabel.numberOfLines = 1
  }
  
  private func setTitleLabel(_ appearance: Appearance) {
    titleLabel.textColor = appearance.primaryTextColor
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().inset(10)
    }
  }
}
