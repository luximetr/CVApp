//
//  SkillsListView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListView: InitView {
  
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
  
  private func setupTableView() {
    
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
