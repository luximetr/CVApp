//
//  SettingsVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsVCOutput {
  func didTapOnChangeLanguage(in vc: UIViewController)
  func didTapOnChangeTheme(in vc: UIViewController)
  func didSignOut(in vc: UIViewController)
}

class SettingsVC: ScreenController, CurrentThemeChangedObserver, PopupAlertDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: SettingsView
  
  private let tableViewController = TableViewController()
  
  private var changeLanguageItem = TitleValueItemCellConfigurator()
  private var changeThemeItem = TitleValueItemCellConfigurator()
  private var signOutItem = SignOutItemCellConfigurator()
  
  // MARK: - Dependencies
  
  var output: SettingsVCOutput!
  var signOutService: SignOutService!
  var themesService: ThemesService!
  var languagesService: LanguagesService!
  
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
    displayCurrentTheme()
    displayCurrentLanguage()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableView()
    setupItemActions()
    setupDataSourceItems()
    changeThemeItem.value.value = themesService.getCurrentTheme().name
  }
  
  private func setupTableView() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func setupObservers() {
    themesService.addCurrentThemeChangedObserver(self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "settings.title")
    changeLanguageItem.title.value = getLocalizedString(key: "settings.language.title")
    changeThemeItem.title.value = getLocalizedString(key: "settings.theme.title")
    signOutItem.title.value = getLocalizedString(key: "settings.sign_out.title")
  }
  
  // MARK: - View - Actions
  
  private func didTapOnChangeLanguage() {
    output.didTapOnChangeLanguage(in: self)
  }
  
  private func didTapOnChangeTheme() {
    output.didTapOnChangeTheme(in: self)
  }
  
  private func didTapOnSignOut() {
    showConfirmSignOutAlert()
  }
  
  // MARK: - Setting Items
  
  private func displaySettingsItems() {
    let dataSource = createDataSource()
    tableViewController.appendItems(dataSource)
  }
  
  private func createDataSource() -> [TableCellConfigurator] {
    return [
      changeLanguageItem,
      changeThemeItem,
      signOutItem
    ]
  }
  
  private func setupDataSourceItems() {
    changeLanguageItem.appearanceService = currentAppearanceService
    changeThemeItem.appearanceService = currentAppearanceService
    signOutItem.appearanceService = currentAppearanceService
  }
  
  private func setupItemActions() {
    changeLanguageItem.tapAction = { [weak self] in self?.didTapOnChangeLanguage() }
    changeThemeItem.tapAction = { [weak self] in self?.didTapOnChangeTheme() }
    signOutItem.tapAction = { [weak self] in self?.didTapOnSignOut() }
  }
  
  // MARK: - Current theme - Display
  
  private func displayCurrentTheme() {
    displayCurrentTheme(themesService.getCurrentTheme())
  }
  
  private func displayCurrentTheme(_ theme: Theme) {
    changeThemeItem.value.value = theme.name
  }
  
  // CurrentThemeChangedObserver
  
  func currentThemeChanged(_ theme: Theme) {
    displayCurrentTheme(theme)
  }
  
  // MARK: - Current language - Display
  
  private func displayCurrentLanguage() {
    displayCurrentLanguage(languagesService.getCurrentLanguage())
  }
  
  private func displayCurrentLanguage(_ language: Language) {
    changeLanguageItem.value.value = language.nativeName
  }
  
  // CurrentLanguageChangedObserver
  
  override func currentLanguageChanged(_ language: Language) {
    super.currentLanguageChanged(language)
    displayCurrentLanguage(language)
  }
  
  // MARK: - Sign out - Confirm Alert
  
  private func showConfirmSignOutAlert() {
    let alert = createConfirmSignOutAlertViewModel(onConfirm: { [weak self] in
      self?.signOut()
    })
    showPopupAlert(viewModel: alert)
  }
  
  private func createConfirmSignOutAlertViewModel(onConfirm: @escaping VoidAction) -> AlertViewModel {
    let confirmAction = AlertAction(
      title: getLocalizedString(key: "settings.confirm_sign_out.confirm"),
      action: { onConfirm() },
      style: .normal)
    let cancelAction = AlertAction(
      title: getLocalizedString(key: "settings.confirm_sign_out.cancel"),
      action: {},
      style: .destructive)
    return AlertViewModel(
      title: getLocalizedString(key: "settings.confirm_sign_out.title"),
      message: getLocalizedString(key: "settings.confirm_sign_out.message"),
      actions: [confirmAction, cancelAction])
  }
  
  // MARK: - Sign out
  
  private func signOut() {
    signOutService.signOutCurrentUser()
    output.didSignOut(in: self)
  }
}
