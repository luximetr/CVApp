//
//  SkillsListVC.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Life cycle
  
  init(view: SkillsListView) {
    selfView = view
    super.init(screenView: view)
    view.backgroundColor = .green
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
