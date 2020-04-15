//
//  ContainerTableCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ContainerTableCellConfigurator<V>: TableCellConfigurator where V: UIView {
  
  var cellId: String { return "cellId" }
  typealias ViewType = V
  typealias CellType = ContainerTableCell<V>
  
  override func registerCell(tableView: UITableView) {
    tableView.register(CellType.self, forCellReuseIdentifier: cellId)
  }
  
  override func createCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    let cell: CellType = tableView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    setupCell(cell)
    return cell
  }
  
  // MARK: - Configure cell
  
  private func setupCell(_ cell: CellType) {
    setupCellUI(cell)
    setupCellViewActions(cell.view)
  }
  
  private func setupCellUI(_ cell: CellType) {
    setupCellViewUI(cell.view)
  }
  
  // MARK: - Configure view
  
  func setupCellViewActions(_ view: ViewType) {
    
  }
  
  func setupCellViewUI(_ view: ViewType) {
    
  }
  
  // MARK: - Find view
  
  func findView() -> ViewType? {
    guard let cell = findCellDelegate?.findCell(controller: self) as? CellType else { return nil }
    return cell.view
  }
  
  override func calculateCellHeight(tableView: UITableView) -> CGFloat {
    let cell = CellType()
    setupCellUI(cell)
    let targetSize = CGSize(width: tableView.bounds.width, height: .infinity)
    return cell.systemLayoutSizeFitting(targetSize).height
  }
  
}
