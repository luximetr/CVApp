//
//  NetworkView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol NetworkViewDelegate: class {
  func didTapOnCV(_ cv: CV)
}

class NetworkView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  private let tableView = UITableView()
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  // MARK: - Dependencies
  
  weak var delegate: NetworkViewDelegate?
  var imageSetService: ImageSetFromURLService!
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTableView()
    tableViewController.tableView = tableView
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(tableView)
    autoLayoutTableView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setTableView(appearance: appearance)
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  private func setTableView(appearance: Appearance) {
    tableView.backgroundColor = appearance.background.primary
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - CVs - Display
  
  func displayCVs(_ CVs: [CV]) {
    
  }
  
  private func createCVCell(_ cv: CV) -> NetworkItemCellConfigurator {
    let cell = NetworkItemCellConfigurator()
    cell.avatarURL.value = cv.userInfo.avatarURL
    cell.title.value = cv.userInfo.name
    cell.subtitle.value = cv.userInfo.role
    cell.imageSetService = imageSetService
    cell.tapAction = { [weak self] in self?.delegate?.didTapOnCV(cv) }
    return cell
  }
}
