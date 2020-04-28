//
//  SelectionListItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SelectionListItemView: InitView {
  
  // MARK: - UI elements
  
  let titleLabel = UILabel()
  private let checkImageView = UIImageView()
  private let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    setupCheckImageView()
    setupDividerView()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(titleLabel)
    addSubview(checkImageView)
    addSubview(dividerView)
    addSubview(actionButton)
    autoLayoutTitleLabel()
    autoLayoutCheckImageView()
    autoLayoutDividerView()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setTitleLabel(appearance: appearance)
    setCheckImageView(appearance: appearance)
    setDividerView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup titleLabel
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.text.primary
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().inset(15)
    }
  }
  
  // MARK: - Setup checkImageView
  
  private func setupCheckImageView() {
    checkImageView.contentMode = .scaleAspectFit
    checkImageView.image = AssetsFactory.tick
  }
  
  private func setCheckImageView(appearance: Appearance) {
    checkImageView.tintColor = appearance.text.positive
  }
  
  private func autoLayoutCheckImageView() {
    checkImageView.snp.makeConstraints { make in
      make.height.width.equalTo(24)
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalToSuperview()
      make.leading.equalTo(titleLabel.snp.trailing).offset(10)
    }
  }
  
  func setCheckImage(visible: Bool) {
    if visible {
      checkImageView.alpha = 1
    } else {
      checkImageView.alpha = 0
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setupDividerView() {
  }
  
  func setDividerView(appearance: Appearance) {
    dividerView.backgroundColor = appearance.divider.background
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
