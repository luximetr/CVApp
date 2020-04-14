//
//  SettingsVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsVCOutput {
  func didTapOnChangeName(sourceVC: UIViewController)
  func didSignOut(sourceVC: UIViewController)
}

class SettingsVC: ScreenController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - UI elements
  
  private let selfView: SettingsView
  
  private let dataSource = SettingsAction.allCases
  
  private let cellId = "ItemCell"
  
  // MARK: - Dependencies
  
  var output: SettingsVCOutput!
  var signOutService: SignOutService!
  
  // MARK: - Life cycle
  
  init(view: SettingsView) {
    selfView = view
    super.init()
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
    setupTableView()
    displayTextValues()
  }
  
  private func setupTableView() {
    selfView.tableView.dataSource = self
    selfView.tableView.delegate = self
    selfView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    navigationItem.title = "Settings"
  }
  
  // MARK: - View - Actions
  
  // MARK: - Actions
  
  private func didSelectAction(_ action: SettingsAction) {
    switch action {
    case .changeAvatar: break
    case .changeName: output.didTapOnChangeName(sourceVC: self)
    case .language: break
    case .theme: break
    case .signOut: signOut()
    }
  }
  
  // MARK: - Sign out
  
  private func signOut() {
    signOutService.signOutCurrentUser()
    output.didSignOut(sourceVC: self)
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let action = dataSource[indexPath.row]
    cell.textLabel?.text = action.rawValue
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let action = dataSource[indexPath.row]
    didSelectAction(action)
  }
}

// MARK: - Settings actions

enum SettingsAction: String, CaseIterable {
  case changeAvatar = "Avatar"
  case changeName = "Name"
  case language = "Language"
  case theme = "Theme"
  case signOut = "signOut"
}
