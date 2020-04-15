//
//  ChangeNameItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameItemView: InitView {
  
  // MARK: - UI elements
  
  let titleLabel = UILabel()
  let arrowImageView = UIImageView()
  let dividerView = UIView()
  private let actionButton = UIButton()
  
  // MARK: - Actions
  
  var tapAction: VoidAction?
  
  // MARK: - Setup
  
  override func setup() {
    setupSelf()
    setupTitleLabel()
    setupArrowImageView()
    setupDividerView()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(titleLabel)
    addSubview(arrowImageView)
    addSubview(dividerView)
    addSubview(actionButton)
    autoLayoutTitleLabel()
    autoLayoutArrowImageView()
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
  
  // MARK: - Setup arrowImageView
  
  private func setupArrowImageView() {
    arrowImageView.contentMode = .scaleAspectFit
  }
  
  private func autoLayoutArrowImageView() {
    arrowImageView.snp.makeConstraints { make in
      make.height.width.equalTo(24)
      make.trailing.equalToSuperview().inset(24)
      make.center.equalToSuperview()
    }
  }
  
  // MARK: - Setup dividerView
  
  private func setupDividerView() {
    dividerView.backgroundColor = .lightGray
  }
  
  private func autoLayoutDividerView() {
    dividerView.snp.makeConstraints { make in
      make.height.equalTo(1)
      make.leading.equalTo(titleLabel)
      make.bottom.trailing.equalToSuperview()
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
