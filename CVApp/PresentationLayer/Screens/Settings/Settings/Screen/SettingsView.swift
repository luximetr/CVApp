//
//  SettingsView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  let tableView = UITableView()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
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
    setTableView(appearance: appearance)
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
  }
  
  private func setTableView(appearance: Appearance) {
    tableView.backgroundColor = appearance.background.primary
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
    }
  }
}
