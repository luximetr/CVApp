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

class SettingsVC: ScreenController {
  
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
  
  // MARK: - Life cycle
  
  init(view: SettingsView) {
    selfView = view
    super.init()
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableView()
    displayTextValues()
    setupItemActions()
    setupDataSource()
  }
  
  private func setupTableView() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func setupDataSource() {
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
  
  private func setupItemActions() {
    changeNameItem.tapAction = { [weak self] in self?.didTapOnChangeName() }
    changeLanguageItem.tapAction = { [weak self] in self?.didTapOnChangeLanguage() }
    changeThemeItem.tapAction = { [weak self] in self?.didTapOnChangeTheme() }
    signOutItem.tapAction = { [weak self] in self?.didTapOnSignOut() }
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
  
  // MARK: - Sign out
  
  private func signOut() {
    signOutService.signOutCurrentUser()
    output.didSignOut(in: self)
  }
}
