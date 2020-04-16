//
//  LeftNavigationButtonView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class LeftNavigationButtonView: InitView {
  
  // MARK: - UI elements
  
  let imageView = UIImageView()
  let actionButton = UIButton()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupSelf()
    setupImageView()
    setupActionButton()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(imageView)
    addSubview(actionButton)
    autoLayoutImageView()
    autoLayoutActionButton()
  }
  
  // MARK: - Setup self
  
  private func setupSelf() {
    backgroundColor = .clear
  }
  
  // MARK: - Setup imageView
  
  private func setupImageView() {
    imageView.contentMode = .scaleAspectFit
  }
  
  private func autoLayoutImageView() {
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().inset(10)
      make.leading.equalToSuperview().offset(13)
    }
  }
  
  // MARK: - Setup actionButton
  
  private func setupActionButton() {
    
  }
  
  private func autoLayoutActionButton() {
    actionButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}
