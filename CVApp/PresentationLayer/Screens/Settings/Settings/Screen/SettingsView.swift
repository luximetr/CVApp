//
//  SettingsView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
  func didTapOnChangeLanguage()
  func didTapOnChangeTheme()
  func didTapOnSignOut()
}

class SettingsView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  private let tableView = UITableView()
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  let changeLanguageItem = TitleValueItemCellConfigurator()
  let changeThemeItem = TitleValueItemCellConfigurator()
  let signOutItem = SignOutItemCellConfigurator()
  
  // MARK: - Dependencies
  
  weak var delegate: SettingsViewDelegate?
  var appearanceService: AppearanceService!
  
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
    tableViewController.tableView = tableView
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.showsVerticalScrollIndicator = false
  }
  
  private func setTableView(appearance: Appearance) {
    tableView.backgroundColor = appearance.background.primary
    tableView.indicatorStyle = appearance.scrollIndicator.style
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Display items
  
  func displaySettingsItems() {
    let dataSource = createDataSource()
    tableViewController.appendItems(dataSource)
    setupDataSourceItems()
    setupItemActions()
  }
  
  private func createDataSource() -> [TableCellConfigurator] {
    return [
      changeLanguageItem,
      changeThemeItem,
      signOutItem
    ]
  }
  
  private func setupDataSourceItems() {
    changeLanguageItem.appearanceService = appearanceService
    changeThemeItem.appearanceService = appearanceService
    signOutItem.appearanceService = appearanceService
  }
  
  private func setupItemActions() {
    changeLanguageItem.tapAction = { [weak self] in
      self?.delegate?.didTapOnChangeLanguage()
    }
    changeThemeItem.tapAction = { [weak self] in
      self?.delegate?.didTapOnChangeTheme()
    }
    signOutItem.tapAction = { [weak self] in
      self?.delegate?.didTapOnSignOut()
    }
  }
}
