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
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTitleLabel()
    setupSubtitleLabel()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(avatarView)
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    addSubview(actionButton)
    autoLayoutAvatarView()
    autoLayoutTitleLabel()
    autoLayoutSubtitleLabel()
    autoLayoutActionButton()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setAvatarView(appearance: appearance)
    setTitleLabel(appearance: appearance)
    setSubtitleLabel(appearance: appearance)
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
    let side: CGFloat = 40
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
      make.leading.equalTo(avatarView.snp.trailing).offset(5)
      make.top.equalTo(avatarView)
      make.trailing.equalToSuperview().inset(24)
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
