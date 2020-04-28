//
//  TitleValueItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TitleValueItemView: InitView {
  
  // MARK: - UI elements
  
  let titleLabel = UILabel()
  let valueLabel = UILabel()
  let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTitleLabel()
    setupValueLabel()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(titleLabel)
    addSubview(valueLabel)
    addSubview(dividerView)
    addSubview(actionButton)
    autoLayoutTitleLabel()
    autoLayoutValueLabel()
    autoLayoutDividerView()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setTitleLabel(appearance: appearance)
    setValueLabel(appearance: appearance)
    setDividerView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.numberOfLines = 1
  }
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.primaryTextColor
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().inset(15)
    }
  }
  
  // MARK: - Setup valueLabel
  
  private func setupValueLabel() {
    valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    valueLabel.setContentHuggingPriority(.required, for: .horizontal)
  }
  
  private func setValueLabel(appearance: Appearance) {
    valueLabel.textColor = appearance.secondaryTextColor
  }
  
  private func autoLayoutValueLabel() {
    valueLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalTo(titleLabel)
      make.leading.equalTo(titleLabel.snp.trailing).offset(10)
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setDividerView(appearance: Appearance) {
    dividerView.backgroundColor = appearance.dividerBackgroundColor
  }
  
  private func autoLayoutDividerView() {
    dividerView.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel)
      make.trailing.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
  
  // MARK: - Setup actionButton
  
  private func setupActionButton() {
    actionButton.addAction(self, action: #selector(didTapOnActionButton))
  }
  
  private func autoLayoutActionButton() {
    actionButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  @objc
  private func didTapOnActionButton() {
    tapAction?()
  }
  
}
