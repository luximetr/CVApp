//
//  NumbersItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NumbersItemCellConfigurator: ContainerTableCellConfigurator<NumbersItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "numbersItemCell" }
  
  // MARK: - Data
  
  private let number: String
  let title: Bindable<String>
  
  // MARK: - Life cycle
  
  init(number: String) {
    self.number = number
    self.title = Bindable("")
    super.init()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
  }
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, number: number)
    setupView(view, title: title.value)
  }
  
  private func setupView(_ view: ViewType, number: String) {
    view.numberLabel.text = number
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
}
