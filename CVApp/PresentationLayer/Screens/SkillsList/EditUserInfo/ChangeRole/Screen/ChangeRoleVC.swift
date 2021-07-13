//
//  ChangeRoleVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeRoleVCOutput: AnyObject {
  func didTapOnBack(in vc: UIViewController)
  func roleChangingFinished(in vc: UIViewController)
}

class ChangeRoleVC: ScreenController, OverScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: ChangeRoleView
  
  // MARK: - Dependencies
  
  var output: ChangeRoleVCOutput?
  var changeRoleService: ChangeCVUserRoleService!
  var showErrorAlertService: ShowErrorAlertService!
  
  // MARK: - Data
  
  private let cvId: CVIdType
  private let role: String
  
  // MARK: - Life cycle
  
  init(view: ChangeRoleView,
       cvId: CVIdType,
       role: String,
       currentApperanceService: AppearanceService) {
    selfView = view
    self.cvId = cvId
    self.role = role
    super.init(
      screenView: view,
      currentAppearanceService: currentApperanceService)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    selfView.inputField.becomeFirstResponder()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupViewActions()
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
    selfView.continueButton.addAction(self, action: #selector(didTapOnContinueButton))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_role.title")
    selfView.continueButton.title = getLocalizedString(key: "change_role.continue.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  @objc
  private func didTapOnContinueButton() {
    guard let role = selfView.inputField.text, !role.isEmpty else { return }
    changeRole(role)
  }
  
  // MARK: - Role - Change
  
  private func changeRole(_ role: String) {
    showOverScreenLoader()
    changeRoleService.changeRole(cvId: cvId, role: role, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.hideOverScreenLoader()
      switch result {
      case .success:
        strongSelf.output?.roleChangingFinished(in: strongSelf)
      case .failure(let error):
        strongSelf.showErrorAlertService.showRepeatErrorAlert(
          message: error.message, in: strongSelf, onRepeat: {
            self?.changeRole(role)
        })
      }
    })
  }
}
