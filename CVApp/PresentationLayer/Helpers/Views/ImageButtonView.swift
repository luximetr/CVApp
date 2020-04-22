//
//  ImageButtonView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SnapKit

class ImageButtonView: InitView {
  
  // MARK: - UI elements
  
  let imageView = UIImageView()
  let button = UIButton()
  
  // MARK: - Constraints
  
  private var imageViewHeight: Constraint?
  private var imageViewWidth: Constraint?
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupImageView()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(imageView)
    addSubview(button)
    autoLayoutImageView()
    autoLayoutButton()
  }
  
  // MARK: - Setup self
  
  override var tintColor: UIColor! {
    didSet { imageView.tintColor = tintColor }
  }
  
  // MARK: - Setup imageView
  
  private func setupImageView() {
    imageView.contentMode = .scaleAspectFit
  }
  
  private func autoLayoutImageView() {
    imageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      imageViewHeight = make.height.equalTo(40).constraint
      imageViewWidth = make.width.equalTo(40).constraint
    }
  }
  
  func setImageView(size: CGSize) {
    imageViewHeight?.update(offset: size.height)
    imageViewWidth?.update(offset: size.width)
  }
  
  var image: UIImage? {
    set { imageView.image = newValue }
    get { return imageView.image }
  }
  
  // MARK: - Setup button
  
  private func autoLayoutButton() {
    button.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func addAction(_ target: Any, action: Selector) {
    button.addAction(target, action: action)
  }
}
