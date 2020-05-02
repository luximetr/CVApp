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

class SettingsVC: ScreenController, CurrentThemeChangedObserver, SettingsViewDelegate {
  
  // MARK: - UI elements
  
  private let selfView: SettingsView
  
  // MARK: - Dependencies
  
  var output: SettingsVCOutput!
  var signOutService: SignOutService!
  var themesService: ThemesService!
  var languagesService: LanguagesService!
  var showPopupAlertService: ShowPopupAlertService!
  
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
    displayCurrentTheme()
    displayCurrentLanguage()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    selfView.displaySettingsItems()
  }
  
  private func setupObservers() {
    themesService.addCurrentThemeChangedObserver(self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "settings.title")
    selfView.changeLanguageItem.title.value = getLocalizedString(key: "settings.language.title")
    selfView.changeThemeItem.title.value = getLocalizedString(key: "settings.theme.title")
    selfView.signOutItem.title.value = getLocalizedString(key: "settings.sign_out.title")
  }
  
  // MARK: - View - Actions
  
  func didTapOnChangeLanguage() {
    output.didTapOnChangeLanguage(in: self)
  }
  
  func didTapOnChangeTheme() {
    output.didTapOnChangeTheme(in: self)
  }
  
  func didTapOnSignOut() {
    showConfirmSignOutAlert()
  }
  
  // MARK: - Current theme - Display
  
  private func displayCurrentTheme() {
    displayCurrentTheme(themesService.getCurrentTheme())
  }
  
  private func displayCurrentTheme(_ theme: Theme) {
    selfView.changeThemeItem.value.value = theme.name
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
    selfView.changeLanguageItem.value.value = language.nativeName
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
    showPopupAlertService.showPopupAlert(viewModel: alert, in: self)
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
