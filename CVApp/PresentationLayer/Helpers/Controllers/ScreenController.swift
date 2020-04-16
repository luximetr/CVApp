//
//  ScreenController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

typealias ScreenView = (UIView & AppearanceConfigurable)

class ScreenController: UIViewController, CurrentAppearanceChangedObserver {
  
  // MARK: - UI elements
  
  var screenView: ScreenView
  
  // MARK: - Dependencies
  
  var appearanceService: AppearanceService! {
    didSet { appearanceService.addCurrentAppearanceChanged(observer: self) }
  }
  
  // MARK: - Life cycle
  
  public init(screenView: ScreenView) {
    self.screenView = screenView
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    self.screenView = InitView()
    super.init(coder: aDecoder)
  }
  
  // MARK: - View life cycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    initConfigure()
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    disableSwipeToBackIfNeeded()
    setNeedsStatusBarAppearanceUpdate() 
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    enableSwipeToBackIfNeeded()
  }
  
  // MARK: - Init configure
  
  open func initConfigure() {
    setSelf(appearance: appearanceService.getCurrentAppearance())
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
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    let convertor = StatusBarStyleConvertor()
    return convertor.toUIStatusBarStyle(statusBarStyle)
  }
  
  var statusBarStyle: StatusBarStyle = .dark {
    didSet { setNeedsStatusBarAppearanceUpdate() }
  }
  
  // MARK: - Appearance
  // CurrentAppearanceChangedObserver
  
  func currentAppearanceChanged(_ appearance: Appearance) {
    setSelf(appearance: appearance)
  }
  
  private func setSelf(appearance: Appearance) {
    screenView.setAppearance(appearance)
    statusBarStyle = appearance.statusBarStyle
  }
}
