//
//  ScreenController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

typealias ScreenView = (UIView & AppearanceConfigurable)

class ScreenController: InitViewController, CurrentAppearanceChangedObserver, CurrentLanguageChangedObserver {
  
  // MARK: - UI elements
  
  var screenView: ScreenView
  
  // MARK: - Dependencies
  
  let currentAppearanceService: AppearanceService
  var currentLanguageService: LanguagesService? {
    didSet { currentLanguageService?.addCurrentLanguageChanged(observer: self) }
  }
  var stringsLocalizeService: StringsLocalizeService?
  
  // MARK: - Life cycle
  
  public init(
      screenView: ScreenView,
      currentAppearanceService: AppearanceService) {
    self.screenView = screenView
    self.currentAppearanceService = currentAppearanceService
    super.init()
    currentAppearanceService.addCurrentAppearanceChanged(observer: self)
  }
  
  // MARK: - View life cycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    initConfigure()
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    disableSwipeToBackIfNeeded()
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    enableSwipeToBackIfNeeded()
  }
  
  // MARK: - Init configure
  
  open func initConfigure() {
    setupAppearance()
    displayTextValues()
  }
  
  // MARK: - Swipe to back
  
  open var swipeToBackEnabled: Bool {
    return true
  }
  
  private func disableSwipeToBackIfNeeded() {
    if !swipeToBackEnabled {
      navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
  }
  
  private func enableSwipeToBackIfNeeded() {
    if !swipeToBackEnabled {
      navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
  }
  
  // MARK: - Status bar style
  
  final
  override var preferredStatusBarStyle: UIStatusBarStyle {
    let convertor = StatusBarStyleConvertor()
    return convertor.toUIStatusBarStyle(statusBarStyle)
  }
  
  var statusBarStyle: StatusBarStyle {
    let appearance = currentAppearanceService.getCurrentAppearance()
    return appearance.statusBar.style
  }
  
  // MARK: - Appearance
  // CurrentAppearanceChangedObserver
  
  func currentAppearanceChanged(_ appearance: Appearance) {
    setSelf(appearance: appearance)
  }
  
  private func setSelf(appearance: Appearance) {
    screenView.setAppearance(appearance)
    setNeedsStatusBarAppearanceUpdate()
  }
  
  private func setupAppearance() {
    let appearance = currentAppearanceService.getCurrentAppearance()
    setSelf(appearance: appearance)
  }
  
  // MARK: - Localization
  // CurrentLanguageChangedObserver
  
  func currentLanguageChanged(_ language: Language) {
    displayTextValues()
  }
  
  func displayTextValues() {
    
  }
  
  func getLocalizedString(key: String) -> String {
    return getLocalizedString(key: key, [])
  }
  
  func getLocalizedString(key: String, _ args: CVarArg...) -> String {
    return stringsLocalizeService?.getLocalizedString(key: key, args: args) ?? key
  }
}
