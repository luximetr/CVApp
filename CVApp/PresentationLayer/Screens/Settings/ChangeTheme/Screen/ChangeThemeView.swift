//
//  ChangeThemeView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeThemeView: InitView {
  
  // MARK: - UI elements
  
  let tableView = UITableView()
  
  // MARK: - Setup
  
  override func setup() {
    setupTableView()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    addSubview(tableView)
    autoLayoutTableView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    tableView.backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
