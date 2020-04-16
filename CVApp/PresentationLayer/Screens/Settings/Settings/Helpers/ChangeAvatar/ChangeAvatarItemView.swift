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
  let editButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupAvatarView()
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
    backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func setAvatarView(appearance: Appearance) {
    
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
    
  }
  
  private func autoLayoutEditButton() {
    
  }
  
}
