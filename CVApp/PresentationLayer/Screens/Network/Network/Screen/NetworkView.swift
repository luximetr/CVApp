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

class NetworkView: ScreenNavigationBarView, FullScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  let loaderView = FullScreenLoaderView()
  private let tableView = UITableView()
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  // MARK: - Dependencies
  
  weak var delegate: NetworkViewDelegate?
  var imageSetService: ImageSetFromURLService!
  var appearanceService: AppearanceService!
  
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
    setFullScreenLoader(appearance: appearance)
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  private func setTableView(appearance: Appearance) {
    tableView.backgroundColor = appearance.background.primary
    tableView.indicatorStyle = appearance.scrollIndicator.style
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Setup loader
  
  func placeFullScreenLoader(_ view: FullScreenLoaderView) {
    view.snp.makeConstraints { make in
      make.edges.equalTo(tableView)
    }
  }
  
  // MARK: - CVs - Display
  
  func displayCVs(_ CVs: [CV]) {
    let cells = createCVCells(CVs)
    tableViewController.reloadItems(cells, animated: false)
  }
  
  // MARK: - Create CV Cells
  
  private func createCVCells(_ CVs: [CV]) -> [NetworkItemCellConfigurator] {
    return CVs.map { createCVCell($0) }
  }
  
  private func createCVCell(_ cv: CV) -> NetworkItemCellConfigurator {
    let cell = NetworkItemCellConfigurator()
    cell.avatarURL.value = cv.userInfo.avatarURL
    cell.title.value = cv.userInfo.name
    cell.subtitle.value = cv.userInfo.role
    cell.imageSetService = imageSetService
    cell.appearanceService = appearanceService
    cell.tapAction = { [weak self] in self?.delegate?.didTapOnCV(cv) }
    return cell
  }
}
