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
    setupSelf()
    setupAvatarView()
    setupEditButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(avatarView)
    addSubview(editButton)
    autoLayoutAvatarView()
    autoLayoutEditButton()
  }
  
  // MARK: - Setup self
  
  private func setupSelf() {
    
  }
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func autoLayoutAvatarView() {
    let height: CGFloat = 80
    avatarView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.height.equalTo(height)
      make.width.equalTo(avatarView.snp.height)
      make.top.bottom.equalToSuperview()
    }
    avatarView.layer.cornerRadius = height / 2
  }
  
  // MARK: - Setup editButton
  
  private func setupEditButton() {
    
  }
  
  private func autoLayoutEditButton() {
    
  }
  
}
