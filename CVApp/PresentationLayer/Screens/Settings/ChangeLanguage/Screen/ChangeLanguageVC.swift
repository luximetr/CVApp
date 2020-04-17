//
//  ChangeLanguageVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeLanguageVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
}

class ChangeLanguageVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: ChangeLanguageView
  
  private let tableViewController = TableViewController()
  private weak var selectedListItem: SelectionListItemCellConfigurator?
  
  // MARK: - Dependencies
  
  var languagesService: LanguagesService!
  var output: ChangeLanguageVCOutput?
  
  // MARK: - Life cycle
  
  init(view: ChangeLanguageView) {
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
    displayTextValues()
    displayLanguagesList()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupTableViewController()
    setupActions()
  }
  
  private func setupTableViewController() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func setupActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    selfView.navigationBarView.titleLabel.text = "Change language"
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  // MARK: - Display languages list
  
  private func displayLanguagesList() {
    let languages = languagesService.getLanguagesList()
    let currentLanguage = languagesService.getCurrentLanguage()
    let cells = createLanguagesCells(languages, currentLanguage: currentLanguage)
    tableViewController.reloadItems(cells)
  }
  
  // MARK: - Language item - Create cell
  
  private func createLanguagesCells(_ languages: [Language], currentLanguage: Language) -> [TableCellConfigurator] {
    return languages.map {
      createLanguageCell(
        $0,
        isCurrent: $0.iso639_1Code == currentLanguage.iso639_1Code)
    }
  }
  
  private func createLanguageCell(_ language: Language, isCurrent: Bool) -> TableCellConfigurator {
    let cell = SelectionListItemCellConfigurator()
    cell.title.value = language.nativeName
    cell.isSelected.value = isCurrent
    cell.appearanceService = appearanceService
    if isCurrent { selectedListItem = cell }
    cell.tapAction = { [weak self, weak cell] in
      guard let cell = cell else { return }
      self?.didTapOnLanguage(language, cell: cell)
    }
    return cell
  }
  
  // MARK: - Language item - Action
  
  private func didTapOnLanguage(_ language: Language, cell: SelectionListItemCellConfigurator) {
    guard cell !== selectedListItem else { return }
    selectedListItem?.isSelected.value = false
    cell.isSelected.value = true
    selectedListItem = cell
    languagesService.changeCurrentLanguage(language)
  }
}
