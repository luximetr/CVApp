//
//  SettingsVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsVCOutput {
  func didTapOnChangeAvatar(in vc: UIViewController)
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
  var languagesService: LanguagesService!
  var remoteImageSetService: RemoteImageSetService!
  var uploadImageService: UploadFileService!
  
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
    changeNameItem.title.value = getLocalizedString(key: "settings.name.title")
    changeLanguageItem.title.value = getLocalizedString(key: "settings.language.title")
    changeThemeItem.title.value = getLocalizedString(key: "settings.theme.title")
    signOutItem.title.value = getLocalizedString(key: "settings.sign_out.title")
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
  
  // MARK: - Setting Items
  
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
    changeAvatarItem.appearanceService = currentAppearanceService
    changeAvatarItem.remoteImageSetService = remoteImageSetService
    changeAvatarItem.tapEditAction = { [weak self] in
      self?.changeAvatar()
    }
    changeNameItem.appearanceService = currentAppearanceService
    changeLanguageItem.appearanceService = currentAppearanceService
    changeThemeItem.appearanceService = currentAppearanceService
    signOutItem.appearanceService = currentAppearanceService
  }
  
  private func setupItemActions() {
    changeNameItem.tapAction = { [weak self] in self?.didTapOnChangeName() }
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
  
  // MARK: - Change avatar
  
  private func changeAvatar() {
    output.didTapOnChangeAvatar(in: self)
  }
  
  // MARK: - Sign out
  
  private func signOut() {
    signOutService.signOutCurrentUser()
    output.didSignOut(in: self)
  }
}
