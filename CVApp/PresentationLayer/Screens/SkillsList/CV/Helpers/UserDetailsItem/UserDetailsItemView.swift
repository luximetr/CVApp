//
//  UserDetailsItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class UserDetailsItemView: InitView {
  
  // MARK: - UI elements
  
  let avatarView = AvatarView()
  let nameLabel = UILabel()
  let roleLabel = UILabel()
  private let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupAvatarView()
    setupNameLabel()
    setupRoleLabel()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      avatarView,
      nameLabel,
      roleLabel,
      dividerView,
      actionButton
    ])
    autoLayoutAvatarView()
    autoLayoutNameLabel()
    autoLayoutRoleLabel()
    autoLayoutDividerView()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setAvatarView(appearance: appearance)
    setNameLabel(appearance: appearance)
    setRoleLabel(appearance: appearance)
    setDividerView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func setAvatarView(appearance: Appearance) {
    avatarView.setAppearance(appearance)
  }
  
  private func autoLayoutAvatarView() {
    let side: CGFloat = 80
    avatarView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().inset(15)
      make.height.width.equalTo(side)
    }
    avatarView.layer.cornerRadius = side / 2
  }
  
  // MARK: - Setup nameLabel
  
  private func setupNameLabel() {
    nameLabel.numberOfLines = 1
    nameLabel.font = .font(ofSize: 18)
  }
  
  private func setNameLabel(appearance: Appearance) {
    nameLabel.textColor = appearance.primaryTextColor
  }
  
  private func autoLayoutNameLabel() {
    nameLabel.snp.makeConstraints { make in
      make.leading.equalTo(avatarView.snp.trailing).offset(10)
      make.top.equalTo(avatarView).offset(18)
      make.trailing.equalToSuperview().inset(24)
    }
  }
  
  // MARK: - Setup roleLabel
  
  private func setupRoleLabel() {
    roleLabel.numberOfLines = 1
  }
  
  private func setRoleLabel(appearance: Appearance) {
    roleLabel.textColor = appearance.secondaryTextColor
  }
  
  private func autoLayoutRoleLabel() {
    roleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(nameLabel)
      make.top.equalTo(nameLabel.snp.bottom).offset(3)
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setDividerView(appearance: Appearance) {
    dividerView.backgroundColor = appearance.dividerBackgroundColor
  }
  
  private func autoLayoutDividerView() {
    dividerView.snp.makeConstraints { make in
      make.bottom.leading.trailing.equalToSuperview()
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
