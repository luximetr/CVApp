//
//  ChangeAvatarItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeAvatarItemView: InitView {
  
  // MARK: - UI elements
  
  let avatarView = AvatarView()
  private let editButton = ImageButtonView()
  
  // MARK: - Actions
  
  var tapEditAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupEditButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(avatarView)
    addSubview(editButton)
    autoLayoutAvatarView()
    autoLayoutEditButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setAvatarView(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
    setAvatarView(appearance: appearance)
    setEditButton(appearance: appearance)
  }
  
  // MARK: - Setup avatarView
  
  private func setAvatarView(appearance: Appearance) {
    avatarView.setAppearance(appearance)
  }
  
  private func autoLayoutAvatarView() {
    let height: CGFloat = 120
    avatarView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.height.equalTo(height)
      make.width.equalTo(avatarView.snp.height)
      make.top.equalToSuperview().offset(24)
      make.bottom.equalToSuperview().inset(10)
    }
    avatarView.layer.cornerRadius = height / 2
  }
  
  // MARK: - Setup editButton
  
  private func setupEditButton() {
    editButton.image = AssetsFactory.edit
    editButton.addAction(self, action: #selector(didTapOnEditButton))
  }
  
  private func setEditButton(appearance: Appearance) {
    editButton.backgroundColor = appearance.action.primary.background
    editButton.tintColor = appearance.action.primary.title
  }
  
  private func autoLayoutEditButton() {
    let side: CGFloat = 40
    editButton.snp.makeConstraints { make in
      make.height.width.equalTo(side)
      make.bottom.trailing.equalTo(avatarView)
    }
    editButton.setImageView(size: .init(side: 20))
    editButton.layer.cornerRadius = side / 2
  }
  
  @objc
  private func didTapOnEditButton() {
    tapEditAction?()
  }
  
}
