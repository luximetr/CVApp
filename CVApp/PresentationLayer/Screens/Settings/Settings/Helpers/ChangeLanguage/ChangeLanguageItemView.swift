//
//  ChangeLanguageItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeLanguageItemView: InitView {
  
  // MARK: - UI elements
  
  let titleLabel = UILabel()
  let valueLabel = UILabel()
  let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    setupSelf()
    setupTitleLabel()
    setupValueLabel()
    setupDividerView()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(titleLabel)
    addSubview(valueLabel)
    addSubview(dividerView)
    addSubview(actionButton)
    autoLayoutTitleLabel()
    autoLayoutValueLabel()
    autoLayoutDividerView()
    autoLayoutActionButton()
  }
  
  // MARK: - Setup self
  
  private func setupSelf() {
    
  }
  
  // MARK: - Setup titleLabel
  
  private func setupTitleLabel() {
    titleLabel.numberOfLines = 1
    titleLabel.textColor = .black
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
    valueLabel.textColor = .lightGray
    valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    valueLabel.setContentHuggingPriority(.required, for: .horizontal)
  }
  
  private func autoLayoutValueLabel() {
    valueLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalTo(titleLabel)
      make.leading.equalTo(titleLabel.snp.trailing).offset(10)
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setupDividerView() {
    dividerView.backgroundColor = .lightGray
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
