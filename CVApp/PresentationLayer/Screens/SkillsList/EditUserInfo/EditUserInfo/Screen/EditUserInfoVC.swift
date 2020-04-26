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
  func didTapOnEditAvatar(in vc: UIViewController, cvId: CVIdType, avatarURL: URL?)
  func didTapOnEditName(in vc: UIViewController, name: String)
  func didTapOnEditRole(in vc: UIViewController, role: String)
}

class EditUserInfoVC: ScreenController, CVAvatarChangedObserver, CurrentUserNameChangedObserver, CurrentUserRoleChangedObserver {
  
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
  
  private let cvId: CVIdType
  private var userInfo: UserInfo
  
  // MARK: - Life cycle
  
  init(view: EditUserInfoView, cvId: CVIdType, userInfo: UserInfo) {
    selfView = view
    self.cvId = cvId
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
  
  func cvAvatarChanged(_ avatarURL: URL) {
    userInfo.avatarURL = avatarURL
    displayAvatar(avatarURL)
  }
  
  // MARK: - Avatar - Action
  
  private func didTapOnAvatar() {
    output?.didTapOnEditAvatar(in: self, cvId: cvId, avatarURL: userInfo.avatarURL)
  }
  
  // MARK: - Name - Display
  
  private func displayName(_ name: String) {
    nameCell.value.value = name
  }
  
  // MARK: - Name - Changed
  // CurrentUserNameChangedObserver
  
  func currentUserNameChanged(_ name: String) {
    userInfo.name = name
    displayName(name)
  }
  
  // MARK: - Name - Action
  
  private func didTapOnName() {
    output?.didTapOnEditName(in: self, name: userInfo.name)
  }
  
  // MARK: - Role - Display
  
  private func displayRole(_ role: String) {
    roleCell.value.value = role
  }
  
  // MARK: - Role - Changed
  // CurrentUserRoleChangedObserver
  
  func currentUserRoleChanged(_ role: String) {
    userInfo.role = role
    displayRole(role)
  }
  
  // MARK: - Role - Action
  
  private func didTapOnRole() {
    output?.didTapOnEditRole(in: self, role: userInfo.role)
  }
  
}
