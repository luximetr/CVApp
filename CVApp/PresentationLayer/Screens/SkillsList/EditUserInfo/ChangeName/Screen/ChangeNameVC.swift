//
//  ChangeNameVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 10/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeNameVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
  func nameChangingFinished(in vc: UIViewController)
}

class ChangeNameVC: ScreenController, OverScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: ChangeNameView
  
  // MARK: - Dependencies
  
  var output: ChangeNameVCOutput?
  var changeUserNameService: ChangeCVUserNameService!
  var showErrorAlertService: ShowErrorAlertService!
  
  // MARK: - Data
  
  let cvId: CVIdType
  let name: String
  
  // MARK: - Life cycle
  
  init(view: ChangeNameView,
       cvId: CVIdType,
       name: String,
       currentAppearanceService: AppearanceService) {
    selfView = view
    self.cvId = cvId
    self.name = name
    super.init(
      screenView: view,
      currentAppearanceService: currentAppearanceService)
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
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  @objc
  private func didTapOnContinueButton() {
    guard let name = selfView.inputField.text, !name.isEmpty else { return }
    changeName(name)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_name.title")
    selfView.continueButton.title = getLocalizedString(key: "change_name.continue.title")
  }
  
  // MARK: - Name - Change
  
  private func changeName(_ name: String) {
    showOverScreenLoader()
    changeUserNameService.changeCVUserName(cvId: cvId, name: name, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.hideOverScreenLoader()
      switch result {
      case .success:
        strongSelf.output?.nameChangingFinished(in: strongSelf)
      case .failure(let error):
        strongSelf.showErrorAlertService.showRepeatErrorAlert(
          message: error.message, in: strongSelf, onRepeat: {
            self?.changeName(name)
        })
      }
    })
  }
  
}
