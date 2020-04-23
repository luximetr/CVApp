//
//  ChangeNameItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameItemCellConfigurator: ContainerTableCellConfigurator<ChangeNameItemView> {
  
  override var cellId: String { return "changeNameCell" }
  
  let title: Bindable<String>
  
  init(title: String) {
    self.title = Bindable(title)
    super.init()
    bindData()
  }
  
  // MARK: - Bind data
  
  private func bindData() {
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
  }
  
  // MARK: - Setup view
  
  override func setupCellViewUI(_ view: ViewType) {
    setupView(view, title: title.value)
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
}
