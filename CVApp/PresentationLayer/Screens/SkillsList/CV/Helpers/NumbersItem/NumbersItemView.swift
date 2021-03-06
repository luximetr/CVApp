//
//  NumbersItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NumbersItemView: InitView {
  
  // MARK: - UI elements
  
  let numberLabel = UILabel()
  let titleLabel = UILabel()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNumberLabel()
    setupTitleLabel()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      numberLabel,
      titleLabel
    ])
    autoLayoutNumberLabel()
    autoLayoutTitleLabel()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setNumberLabel(appearance: appearance)
    setTitleLabel(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup numberLabel
  
  private func setupNumberLabel() {
    numberLabel.numberOfLines = 1
    numberLabel.font = .font(ofSize: 20, weight: .medium)
    numberLabel.setContentHuggingPriority(.required, for: .horizontal)
    numberLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
  }
  
  private func setNumberLabel(appearance: Appearance) {
    numberLabel.textColor = appearance.text.primary
  }
  
  private func autoLayoutNumberLabel() {
    numberLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalTo(titleLabel)
    }
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.font = .font(ofSize: 18)
    titleLabel.numberOfLines = 0
  }
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.text.primary
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(7)
      make.bottom.equalToSuperview().inset(15)
      make.leading.equalTo(numberLabel.snp.trailing).offset(10)
      make.trailing.equalToSuperview().inset(24)
    }
  }
}
