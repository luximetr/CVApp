//
//  ScreenNavigationBarView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ScreenNavigationBarView: InitView {
  
  // MARK: - UI elements
  
  let statusBarView = UIView()
  let navigationBarView = TitledNavigationBarView()
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(statusBarView)
    addSubview(navigationBarView)
    autoLayoutNavigationBarView()
    autoLayoutStatusBarView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setNavigationBarView(appearance: appearance)
    setStatusBarView(appearance: appearance)
  }
  
  // MARK: - Setup navigationBarView
  
  private func setNavigationBarView(appearance: Appearance) {
    navigationBarView.setAppearance(appearance)
  }
  
  func autoLayoutNavigationBarView() {
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(safeArea.top)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(getNavigationBarHeight())
    }
  }
  
  private func getNavigationBarHeight() -> CGFloat {
    return UINavigationController().navigationBar.frame.height
  }
  
  // MARK: - Setup statusBarView
  
  private func setStatusBarView(appearance: Appearance) {
    statusBarView.backgroundColor = appearance.navigation.background
  }
  
  func autoLayoutStatusBarView() {
    statusBarView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalTo(safeArea.top)
    }
  }
}
