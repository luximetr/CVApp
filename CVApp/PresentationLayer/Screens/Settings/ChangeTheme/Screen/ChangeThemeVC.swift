//
//  ChangeThemeVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeThemeVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
}

class ChangeThemeVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: ChangeThemeView
  
  private let tableViewController = TableViewController()
  private weak var selectedListItem: SelectionListItemCellConfigurator?
  
  // MARK: - Dependencies
  
  var appearanceService: AppearanceService!
  var themesService: ThemesService!
  var output: ChangeThemeVCOutput?
  
  // MARK: - Life cycle
  
  init(view: ChangeThemeView) {
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
    setupObservers()
    displayThemesList()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableViewController()
    setupViewActions()
    selfView.setAppearance(appearanceService.getCurrentAppearance())
  }
  
  private func setupTableViewController() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_theme.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  // MARK: - Setup observers
  
  private func setupObservers() {
    appearanceService.addCurrentAppearanceChanged(observer: self)
  }
  
  // MARK: - Themes - Display
  
  private func displayThemesList() {
    let themes = themesService.getThemesList()
    let currentTheme = themesService.getCurrentTheme()
    let cells = createThemesCells(themes: themes, currentTheme: currentTheme)
    tableViewController.reloadItems(cells)
  }
  
  // MARK: - Themes item - Create cell
  
  private func createThemesCells(
      themes: [Theme], currentTheme: Theme) -> [TableCellConfigurator] {
    return themes.map { createThemeCell($0, isCurrent: $0.type == currentTheme.type) }
  }
  
  private func createThemeCell(_ theme: Theme, isCurrent: Bool) -> TableCellConfigurator {
    let cell = SelectionListItemCellConfigurator()
    cell.title.value = theme.name
    cell.isSelected.value = isCurrent
    cell.appearanceService = currentAppearanceService
    if isCurrent { selectedListItem = cell }
    cell.tapAction = { [weak self, weak cell] in
      guard let cell = cell else { return }
      self?.didTapOnTheme(theme, cell: cell)
    }
    return cell
  }
  
  // MARK: - Themes item - Action
  
  private func didTapOnTheme(_ theme: Theme, cell: SelectionListItemCellConfigurator) {
    guard cell !== selectedListItem else { return }
    selectedListItem?.isSelected.value = false
    cell.isSelected.value = true
    selectedListItem = cell
    themesService.changeCurrentTheme(theme)
  }
}
