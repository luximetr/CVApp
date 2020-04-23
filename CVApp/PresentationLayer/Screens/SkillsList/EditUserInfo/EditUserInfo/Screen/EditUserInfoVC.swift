//
//  EditUserInfoVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol EditUserInfoVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
  func didTapOnEditAvatar(in vc: UIViewController)
  func didTapOnEditName(in vc: UIViewController)
  func didTapOnEditRole(in vc: UIViewController)
}

class EditUserInfoVC: ScreenController, CurrentUserAvatarChangedObserver, CurrentUserNameChangedObserver {
  
  // MARK: - UI elements
  
  private let selfView: EditUserInfoView
  
  private let tableViewController = TableViewController()
  
  private let avatarCell = ChangeAvatarCellConfigurator()
  private let nameCell = TitleValueItemCellConfigurator()
  private let roleCell = TitleValueItemCellConfigurator()
  
  // MARK: - Dependencies
  
  var output: EditUserInfoVCOutput?
  var imageSetService: ImageSetFromURLService!
  
  // MARK: - Data
  
  private var userInfo: UserInfo
  
  // MARK: - Life cycle
  
  init(view: EditUserInfoView, userInfo: UserInfo) {
    selfView = view
    self.userInfo = userInfo
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    displayListItems()
    displayAvatar(userInfo.avatarURL)
    displayName(userInfo.name)
    displayRole(userInfo.role)
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupViewActions()
    setupListItems()
    setupTableViewController()
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
  }
  
  private func setupTableViewController() {
    tableViewController.tableView = selfView.tableView
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "edit_user_info.title");
    nameCell.title.value = getLocalizedString(key: "edit_user_info.name")
    roleCell.title.value = getLocalizedString(key: "edit_user_info.role")
  }
  
  // MARK: - List - Display
  
  private func displayListItems() {
    let dataSource = createDataSource()
    tableViewController.reloadItems(dataSource, animated: false)
  }
  
  private func createDataSource() -> [TableCellConfigurator] {
    return [
      avatarCell,
      nameCell,
      roleCell
    ]
  }
  
  // MARK: - List - Setup
  
  private func setupListItems() {
    avatarCell.tapEditAction = { [weak self] in self?.didTapOnAvatar() }
    avatarCell.imageSetService = imageSetService
    avatarCell.appearanceService = currentAppearanceService
    nameCell.tapAction = { [weak self] in self?.didTapOnName() }
    nameCell.appearanceService = currentAppearanceService
    roleCell.tapAction = { [weak self] in self?.didTapOnRole() }
    roleCell.appearanceService = currentAppearanceService
  }
  
  // MARK: - Avatar - Display
  
  private func displayAvatar(_ imageURL: URL?) {
    avatarCell.imageURL.value = imageURL
  }
  
  // MARK: - Avatar - Changed
  // CurrentUserAvatarChangedObserver
  
  func currentUserAvatarChanged(_ avatarURL: URL) {
    displayAvatar(avatarURL)
  }
  
  // MARK: - Avatar - Action
  
  private func didTapOnAvatar() {
    output?.didTapOnEditAvatar(in: self)
  }
  
  // MARK: - Name - Display
  
  private func displayName(_ name: String) {
    nameCell.value.value = name
  }
  
  // MARK: - Name - Changed
  // CurrentUserNameChangedObserver
  
  func currentUserNameChanged(_ name: String) {
    displayName(name)
  }
  
  // MARK: - Name - Action
  
  private func didTapOnName() {
    output?.didTapOnEditName(in: self)
  }
  
  // MARK: - Role - Display
  
  private func displayRole(_ role: String) {
    roleCell.value.value = role
  }
  
  // MARK: - Role - Action
  
  private func didTapOnRole() {
    output?.didTapOnEditRole(in: self)
  }
  
}
