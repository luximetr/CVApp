//
//  SettingsView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SettingsView: InitView {
  
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
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
