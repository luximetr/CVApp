//
//  ChangeThemeVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeThemeVCOutput: class {
  func themeChangingFinished(at vc: UIViewController)
}

class ChangeThemeVC: ScreenController, CurrentThemeChangedObserver {
  
  // MARK: - UI elements
  
  private let selfView: ChangeThemeView
  
  private let tableViewController = TableViewController()
  
  // MARK: - Dependencies
  
  var themesService: ThemesService!
  var output: ChangeThemeVCOutput!
  
  // MARK: - Life cycle
  
  init(view: ChangeThemeView) {
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
    displayThemesList()
    themesService.addCurrentThemeChangedObserver(self)
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableViewController()
  }
  
  private func setupTableViewController() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func displayThemesList() {
    let themes = themesService.getThemesList()
    let cells = createThemesCells(themes)
    tableViewController.reloadItems(cells)
  }
  
  // MARK: - Themes item - Create cell
  
  private func createThemesCells(_ themes: [Theme]) -> [TableCellConfigurator] {
    return themes.map { createThemeCell($0) }
  }
  
  private func createThemeCell(_ theme: Theme) -> TableCellConfigurator {
    let cell = SelectionListItemCellConfigurator()
    cell.title.value = theme.name
    cell.tapAction = { [weak self] in self?.didTapOnTheme(theme) }
    return cell
  }
  
  // MARK: - Themes item
  
  private func didTapOnTheme(_ theme: Theme) {
    themesService.changeCurrentTheme(theme)
  }
  
  // MARK: - CurrentThemeChangedObserver
  
  func currentThemeChanged(_ theme: Theme) {
    output.themeChangingFinished(at: self)
  }
}
