//
//  FullScreenLoaderView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 28/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class FullScreenLoaderView: InitView {
  
  // MARK: - UI elements
  
  let loader = UIActivityIndicatorView()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupLoader()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(loader)
    autoLayoutLoader()
  }
  
  // MARK: - Appearence
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance: appearance)
    setLoader(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(appearance: Appearance) {
    backgroundColor = appearance.background.primary
  }
  
  // MARK: - Setup loader
  
  private func setupLoader() {
    loader.startAnimating()
  }
  
  private func setLoader(appearance: Appearance) {
    loader.style = .gray
    loader.color = appearance.text.primary
  }
  
  private func autoLayoutLoader() {
    loader.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
