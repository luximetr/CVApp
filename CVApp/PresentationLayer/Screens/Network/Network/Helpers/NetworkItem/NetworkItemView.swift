//
//  NetworkItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkItemView: InitView {
  
  // MARK: - UI element
  
  let avatarView = AvatarView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  private let rightIconView = UIImageView()
  private let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTitleLabel()
    setupSubtitleLabel()
    setupRightIconView()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(avatarView)
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    addSubview(rightIconView)
    addSubview(dividerView)
    addSubview(actionButton)
    autoLayoutAvatarView()
    autoLayoutTitleLabel()
    autoLayoutSubtitleLabel()
    autoLayoutRightIconView()
    autoLayoutDividerView()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setAvatarView(appearance: appearance)
    setTitleLabel(appearance: appearance)
    setSubtitleLabel(appearance: appearance)
    setRightIconView(appearance: appearance)
    setDividerView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup avatarView
  
  private func setAvatarView(appearance: Appearance) {
    avatarView.setAppearance(appearance)
  }
  
  private func autoLayoutAvatarView() {
    let side: CGFloat = 46
    avatarView.snp.makeConstraints { make in
      make.height.width.equalTo(side)
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(20)
      make.bottom.equalToSuperview().inset(20)
    }
    avatarView.layer.cornerRadius = side / 2
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.font = .font(ofSize: 18)
  }
  
  private func setTitleLabel(appearance: Appearance) {
    titleLabel.textColor = appearance.text.primary
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(avatarView.snp.trailing).offset(10)
      make.top.equalTo(avatarView).offset(2)
      make.trailing.equalToSuperview().inset(44)
    }
  }
  
  // MARK: - Setup subtitleLabel
  
  private func setupSubtitleLabel() {
    subtitleLabel.font = .font(ofSize: 16)
  }
  
  private func setSubtitleLabel(appearance: Appearance) {
    subtitleLabel.textColor = appearance.text.secondary
  }
  
  private func autoLayoutSubtitleLabel() {
    subtitleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp.bottom).offset(3)
    }
  }
  
  // MARK: - Setup rightIconView
  
  private func setupRightIconView() {
    rightIconView.image = AssetsFactory.right_arrow
    
  }
  
  private func setRightIconView(appearance: Appearance) {
    rightIconView.tintColor = appearance.divider.background
  }
  
  private func autoLayoutRightIconView() {
    rightIconView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.height.width.equalTo(12)
      make.trailing.equalToSuperview().inset(12)
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setDividerView(appearance: Appearance) {
    dividerView.backgroundColor = appearance.divider.background
  }
  
  private func autoLayoutDividerView() {
    dividerView.snp.makeConstraints { make in
      make.leading.equalTo(avatarView)
      make.bottom.trailing.equalToSuperview()
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
