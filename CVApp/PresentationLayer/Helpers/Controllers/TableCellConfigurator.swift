//
//  TableCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import DifferenceKit

protocol TableCellConfiguratorFindCellDelegate: class {
  func findCell(controller: TableCellConfigurator) -> UITableViewCell?
}

protocol TableCellConfiguratorUpdatesDelegate: class {
  func updateCellUI(controller: TableCellConfigurator, updationBlock: @escaping VoidAction)
}

class TableCellConfigurator: Differentiable {
  
  // MARK: - Id
  
  typealias DifferenceIdentifier = String
  let id = UUID().uuidString
  var differenceIdentifier: String { return id }
  
  // MARK: - Height
  
  private var cachedCellHeight: CGFloat?
  
  // MARK: - Delegates
  
  weak var findCellDelegate: TableCellConfiguratorFindCellDelegate?
  weak var updatesDelegate: TableCellConfiguratorUpdatesDelegate?
  
  // MARK: - Cell - Register
  
  func registerCell(tableView: UITableView) {
  }
  
  // MARK: - Cell - Create
  
  func createCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  // MARK: - Cell - Height - Get
  
  final func getCellHeight(tableView: UITableView) -> CGFloat {
    if let cachedCellHeight = cachedCellHeight {
        return cachedCellHeight
    } else {
        let cellHeight = calculateCellHeight(tableView: tableView)
        cachedCellHeight = cellHeight
        return cellHeight
    }
  }
  
  // MARK: - Cell - Height - Calculate
  
  func calculateCellHeight(tableView: UITableView) -> CGFloat {
      return 44
  }
  
  // MARK: - Differentiable
  
  func isContentEqual(to source: TableCellConfigurator) -> Bool {
    return id == source.id
  }
  
  // MARK: - Cell updating
  
  func updateCell(_ updationBlock: @escaping VoidAction) {
    cachedCellHeight = nil
    updatesDelegate?.updateCellUI(controller: self, updationBlock: updationBlock)
  }
  
  // MARK: - Find cell
  
  func getCell() -> UITableViewCell? {
    return findCellDelegate?.findCell(controller: self)
  }
  
}
