//
//  ChangeRoleVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeRoleVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
  func roleChangingFinished(in vc: UIViewController)
}

class ChangeRoleVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: ChangeRoleView
  
  // MARK: - Dependencies
  
  var output: ChangeRoleVCOutput?
  
  // MARK: - Data
  
  private let role: String
  
  // MARK: - Life cycle
  
  init(view: ChangeRoleView, role: String) {
    selfView = view
    self.role = role
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    displayOldRole(role)
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupViewActions()
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_role.title")
    selfView.continueButton.title = getLocalizedString(key: "change_role.continue.title")
  }
  
  // MARK: - Actions - Back
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  // MARK: - Role - Display old
  
  private func displayOldRole(_ role: String) {
    selfView.inputField.placeholder = role
  }
}
