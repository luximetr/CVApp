//
//  SkillsListVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListVCOutput {
  
}

class SkillsListVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Dependencies
  
  var output: SkillsListVCOutput!
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  // MARK: - Life cycle
  
  init(view: SkillsListView) {
    selfView = view
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    displaySkillsList()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    tableViewController.tableView = selfView.tableView
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "skills_list.title")
  }
  
  // MARK: - Data source - Setup
  
  private func displaySkillsList() {
    let cell1 = UserDetailsItemCellConfigurator()
    cell1.name.value = "User name"
    cell1.role.value = "Middle iOS developer"
    cell1.appearanceService = currentAppearanceService
    
    let cell2 = ContactItemCellConfigurator(icon: AssetsFactory.phone)
    cell2.title.value = "+6590378917"
    cell2.tapAction = {
      print("call phone")
    }
    cell2.appearanceService = currentAppearanceService
    
    let cell3 = ContactItemCellConfigurator(icon: AssetsFactory.email)
    cell3.title.value = "job.aleksandrorlov@gmail.com"
    cell3.tapAction = {
      print("send mail")
    }
    cell3.appearanceService = currentAppearanceService
    
    let cell4 = ContactItemCellConfigurator(icon: AssetsFactory.telegram)
    cell4.title.value = "https://t.me/luximetr"
    cell4.tapAction = {
      print("open in Telegram")
    }
    cell4.appearanceService = currentAppearanceService
    
    let dataSource = [
      cell1,
      cell2,
      cell3,
      cell4
    ]
    
    tableViewController.reloadItems(dataSource)
  }
  
  // MARK: - User data - Display
  
}
