//
//  TableViewController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import DifferenceKit

class TableViewController: NSObject, UITableViewDataSource, UITableViewDelegate, TableCellConfiguratorFindCellDelegate, TableCellConfiguratorUpdatesDelegate {
  
  // MARK: - View
  
  var tableView: UITableView! {
    didSet { bindNewTableView(oldValue, newValue: tableView) }
  }
  
  // MARK: - Data
  
  typealias ItemType = TableCellConfigurator
  private var dataSource: [ItemType] = []
  
  // MARK: - Append cells
  
  func appendItem(_ item: ItemType, animated: Bool = true) {
    appendItems([item], animated: animated)
  }
  
  func appendItems(_ items: [ItemType], animated: Bool = true) {
    setupNewItems(items)
    var target = dataSource
    target.append(contentsOf: items)
    reloadTable(targetDataSource: target, animated: animated)
  }
  
  func reloadItems(_ items: [ItemType], animated: Bool = true) {
    setupNewItems(items)
    reloadTable(targetDataSource: items, animated: animated)
  }
  
  // MARK: - Reload
  
  private func reloadTable(targetDataSource: [ItemType], animated: Bool) {
    if animated {
      reloadTableAnimated(targetDataSource: targetDataSource)
    } else {
      reloadTableNonAnimated(targetDataSource: targetDataSource)
    }
  }
  
  private func reloadTableAnimated(targetDataSource: [ItemType]) {
    if targetDataSource.isEmpty && dataSource.isEmpty { return }
    let changes = StagedChangeset(source: dataSource, target: targetDataSource)
    tableView.reload(using: changes, with: .fade, setData: { data in
      dataSource = data
    })
  }
  
  private func reloadTableNonAnimated(targetDataSource: [ItemType]) {
    dataSource = targetDataSource
    tableView.reloadData()
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return getItem(indexPath: indexPath).createCell(tableView: tableView, indexPath: indexPath)
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return getItem(indexPath: indexPath).getCellHeight(tableView: tableView)
  }
  
  // MARK: - TableCellConfiguratorFindCellDelegate
  
  func findCell(controller: TableCellConfigurator) -> UITableViewCell? {
    guard let indexPath = findIndexPath(controller: controller) else { return nil }
    return tableView.cellForRow(at: indexPath)
  }
  
  // MARK: - TableCellConfiguratorUpdatesDelegate
  
  func updateCellUI(controller: TableCellConfigurator, updationBlock: @escaping VoidAction) {
    guard let indexPath = findIndexPath(controller: controller) else { return }
    UIView.animate(withDuration: 0, animations: { [weak self] in
        updationBlock()
      self?.tableView.reloadRows(at: [indexPath], with: .none)
    })
  }
  
  // MARK: - Find - Index
  
  private func findIndexPath(controller: TableCellConfigurator) -> IndexPath? {
    guard let index = findIndex(controller: controller) else { return nil }
    return IndexPath(row: index, section: 0)
  }
  
  private func findIndex(controller: TableCellConfigurator) -> Int? {
    return dataSource.firstIndex(where: { $0.id == controller.id })
  }
  
  // MARK: - Get - Item
  
  private func getItem(indexPath: IndexPath) -> ItemType {
    return dataSource[indexPath.row]
  }
  
  // MARK: - Setup new items
  
  private func setupNewItems(_ items: [ItemType]) {
    items.forEach { setupNewItem($0) }
  }
  
  private func setupNewItem(_ item: ItemType) {
    item.registerCell(tableView: tableView)
    item.findCellDelegate = self
    item.updatesDelegate = self
  }
  
  // MARK: - Bind view
  
  private func bindNewTableView(_ oldValue: UITableView?, newValue: UITableView?) {
    if let oldValue = oldValue {
      oldValue.delegate = nil
      oldValue.dataSource = nil
    }
    if let newValue = newValue {
      newValue.delegate = self
      newValue.dataSource = self
    }
  }
}
