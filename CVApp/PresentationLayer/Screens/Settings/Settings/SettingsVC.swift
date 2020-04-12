//
//  SettingsVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

enum SettingsActions: String, CaseIterable {
  case changeAvatar = "Avatar"
  case changeName = "Name"
  case language = "Language"
  case theme = "Theme"
}

protocol SettingsVCInput: class {
  
}

protocol SettingsVCOutput {
  func didTapOnAction(_ action: SettingsActions)
}

class SettingsVC: ScreenController, SettingsVCInput, UITableViewDataSource, UITableViewDelegate {
  
  private let dataSource = SettingsActions.allCases
  private let tableView = UITableView()
  private let cellId = "ItemCell"
  
  var output: SettingsVCOutput!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .orange
    navigationItem.title = "Settings"
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
    output.didTapOnAction(action)
  }
}
