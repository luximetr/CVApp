//
//  TitleItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TitleItemCellConfigurator: ContainerTableCellConfigurator<TitleItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "titleCell" }
  
  // MARK: - Data
  
  let title: Bindable<String>
  var tapAction: VoidAction?
  
  // MARK: - Life cycle
  
  override init() {
    self.title = Bindable("")
    super.init()
    bindView()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
  }
  
  // MARK: - Setup view
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, title: title.value)
  }
  
  override func setupCellViewActions(_ view: ViewType) {
    view.tapAction = tapAction
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
}
