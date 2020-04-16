//
//  SettingsVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsVCOutput {
  func didTapOnChangeName(in vc: UIViewController)
  func didTapOnChangeLanguage(in vc: UIViewController)
  func didTapOnChangeTheme(in vc: UIViewController)
  func didSignOut(in vc: UIViewController)
}

class SettingsVC: ScreenController, CurrentThemeChangedObserver {
  
  // MARK: - UI elements
  
  private let selfView: SettingsView
  
  private let tableViewController = TableViewController()
  
  private let changeAvatarItem = ChangeAvatarCellConfigurator()
  private var changeNameItem = ChangeNameItemCellConfigurator()
  private var changeLanguageItem = ChangeLanguageItemCellConfigurator()
  private var changeThemeItem = ChangeThemeItemCellConfigurator()
  private var signOutItem = SignOutItemCellConfigurator()
  
  // MARK: - Dependencies
  
  var output: SettingsVCOutput!
  var signOutService: SignOutService!
  var themesService: ThemesService!
  
  // MARK: - Life cycle
  
  init(view: SettingsView) {
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
    setupObservers()
    displaySettingsItems()
    displayCurrentTheme(themesService.getCurrentTheme())
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableView()
    displayTextValues()
    setupItemActions()
    setupDataSourceItems()
    changeThemeItem.value.value = themesService.getCurrentTheme().name
  }
  
  private func setupTableView() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func displaySettingsItems() {
    let dataSource = createDataSource()
    tableViewController.appendItems(dataSource)
  }
  
  private func createDataSource() -> [TableCellConfigurator] {
    return [
      changeAvatarItem,
      changeNameItem,
      changeLanguageItem,
      changeThemeItem,
      signOutItem
    ]
  }
  
  private func setupDataSourceItems() {
    changeAvatarItem.appearanceService = appearanceService
    changeNameItem.appearanceService = appearanceService
    changeLanguageItem.appearanceService = appearanceService
    changeThemeItem.appearanceService = appearanceService
    signOutItem.appearanceService = appearanceService
  }
  
  private func setupItemActions() {
    changeNameItem.tapAction = { [weak self] in self?.didTapOnChangeName() }
    changeLanguageItem.tapAction = { [weak self] in self?.didTapOnChangeLanguage() }
    changeThemeItem.tapAction = { [weak self] in self?.didTapOnChangeTheme() }
    signOutItem.tapAction = { [weak self] in self?.didTapOnSignOut() }
  }
  
  private func setupObservers() {
    themesService.addCurrentThemeChangedObserver(self)
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    navigationItem.title = "Settings"
    changeNameItem.title.value = "Name"
    changeLanguageItem.title.value = "Language"
    changeThemeItem.title.value = "Theme"
    signOutItem.title.value = "Sign out"
  }
  
  // MARK: - View - Actions
  
  private func didTapOnChangeName() {
    output.didTapOnChangeName(in: self)
  }
  
  private func didTapOnChangeLanguage() {
    output.didTapOnChangeLanguage(in: self)
  }
  
  private func didTapOnChangeTheme() {
    output.didTapOnChangeTheme(in: self)
  }
  
  private func didTapOnSignOut() {
    signOut()
  }
  
  // MARK: - Current theme - Display
  
  private func displayCurrentTheme(_ theme: Theme) {
    changeThemeItem.value.value = theme.name
  }
  
  // MARK: - Current theme - Changed
  
  func currentThemeChanged(_ theme: Theme) {
    displayCurrentTheme(theme)
  }
  
  // MARK: - Sign out
  
  private func signOut() {
    signOutService.signOutCurrentUser()
    output.didSignOut(in: self)
  }
}
