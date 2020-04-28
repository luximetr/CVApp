//
//  ContactItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ContactItemView: InitView {
  
  // MARK: - UI elements
  
  let imageView = UIImageView()
  let titleLabel = UILabel()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupImageView()
    setupTitleLabel()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      imageView,
      titleLabel,
      actionButton
    ])
    autoLayoutImageView()
    autoLayoutTitleLabel()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setImageView(appearance: appearance)
    setTitleLabel(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup imageView
  
  private func setupImageView() {
    imageView.contentMode = .scaleAspectFit
  }
  
  private func setImageView(appearance: Appearance) {
    imageView.tintColor = appearance.text.primary
  }
  
  private func autoLayoutImageView() {
    imageView.snp.makeConstraints { make in
      make.height.width.equalTo(24)
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().inset(15)
    }
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.font = .font(ofSize: 16)
    titleLabel.numberOfLines = 1
  }
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.text.primary
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(imageView.snp.trailing).offset(15)
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalToSuperview()
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
