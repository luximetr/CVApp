//
//  NetworkCVView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkCVView: SkillsListView {
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
  }
  
  // MARK: - Setup navigationBarView
  
  private func setupNavigationBarView() {
    navigationBarView.leftButton.image = AssetsFactory.left_arrow
  }
}
