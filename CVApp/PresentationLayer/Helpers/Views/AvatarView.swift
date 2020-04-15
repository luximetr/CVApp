//
//  AvatarView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AvatarView: InitView {
  
  // MARK: - UI elements
  
  let imageView = UIImageView()
  let shortTitleLabel = UILabel()
  
  // MARK: - Setup
  
  override func setup() {
    setupSelf()
    setupImageView()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(imageView)
    addSubview(shortTitleLabel)
    autoLayoutImageView()
    autoLayoutShortTitleLabel()
  }
  
  // MARK: - Setup self
  
  private func setupSelf() {
    layer.masksToBounds = true
  }
  
  // MARK: - Setup imageView
  
  private func setupImageView() {
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .lightGray
  }
  
  private func autoLayoutImageView() {
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Setup shortTitleLabel
  
  private func autoLayoutShortTitleLabel() {
    shortTitleLabel.snp.makeConstraints { make in
      make.leading.greaterThanOrEqualToSuperview()
      make.trailing.lessThanOrEqualToSuperview()
      make.center.equalToSuperview()
    }
  }
}
