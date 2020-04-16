//
//  ChangeLanguageItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeLanguageItemCellConfigurator: ContainerTableCellConfigurator<ChangeLanguageItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "changeLanguageCell" }
  
  // MARK: - Data
  
  let title: Bindable<String>
  let value: Bindable<String>
  var tapAction: VoidAction?
  
  // MARK: - Life cycle
  
  override init() {
    self.title = Bindable("")
    self.value = Bindable("")
    super.init()
    bindView()
  }
  
  // MARK: - Bind data
  
  private func bindView() {
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
    value.bind(listener: { [weak self] value in
      guard let view = self?.findView() else { return }
      self?.setupView(view, value: value)
    })
  }
  
  // MARK: - Setup view
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, title: title.value)
    setupView(view, value: value.value)
  }
  
  override func setupCellViewActions(_ view: ViewType) {
    view.tapAction = tapAction
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
  private func setupView(_ view: ViewType, value: String) {
    view.valueLabel.text = value
  }
}
