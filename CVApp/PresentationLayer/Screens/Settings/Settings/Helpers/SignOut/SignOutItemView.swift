//
//  SignOutItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SignOutItemView: InitView {
  
  // MARK: - UI elements
  
  let titleLabel = UILabel()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    setupSelf()
    setupTitleLabel()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(titleLabel)
    addSubview(actionButton)
    autoLayoutTitleLabel()
    autoLayoutActionButton()
  }
  
  // MARK: - Setup self
  
  private func setupSelf() {
    
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.numberOfLines = 1
    titleLabel.textColor = .red
  }
  
  private func autoLayoutTitleLabel() {
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalToSuperview().offset(15)
      make.bottom.equalToSuperview().inset(15)
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
