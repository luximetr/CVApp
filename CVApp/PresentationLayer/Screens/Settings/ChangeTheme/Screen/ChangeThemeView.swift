//
//  ChangeThemeView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeThemeView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  let tableView = UITableView()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
    setupTableView()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(tableView)
    autoLayoutTableView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    tableView.backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup navigationBarView
  
  private func setupNavigationBarView() {
    navigationBarView.leftButton.imageView.image = AssetsFactory.left_arrow
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.top.equalTo(navigationBarView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
