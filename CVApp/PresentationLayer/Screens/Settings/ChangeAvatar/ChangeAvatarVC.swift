//
//  ChangeAvatarVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeAvatarVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
}

class ChangeAvatarVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: ChangeAvatarView
  
  // MARK: - Dependencies
  
  var output: ChangeAvatarVCOutput?
  
  // MARK: - Life cycle
  
  init(view: ChangeAvatarView) {
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
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupViewActions()
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
    selfView.changeAvatarButton.addAction(self, action: #selector(didTapOnChangeAvatarButton))
    selfView.continueButton.addAction(self, action: #selector(didTapOnContinueButton))
  }
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_avatar.title")
    selfView.changeAvatarButton.title = getLocalizedString(key: "change_avatar.change.title")
    selfView.continueButton.title = getLocalizedString(key: "change_avatar.continue.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  @objc
  private func didTapOnChangeAvatarButton() {
    
  }
  
  @objc
  private func didTapOnContinueButton() {
    
  }
}
