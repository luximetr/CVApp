//
//  SelectionListItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SelectionListItemCellConfigurator:
  ContainerTableCellConfigurator<SelectionListItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "selectionListItemCell" }
  
  // MARK: - Data
  
  let title: Bindable<String>
  let isSelected: Bindable<Bool>
  var tapAction: VoidAction?
  
  // MARK: - Life cycle
  
  override init() {
    title = Bindable("")
    isSelected = Bindable(false)
    super.init()
    bindView()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
    isSelected.bind(listener: { [weak self] isSelected in
      guard let view = self?.findView() else { return }
      self?.setupView(view, isSelected: isSelected)
    })
  }
  
  // MARK: - Setup view
  
  override func setupCellViewUI(_ view: ViewType) {
    setupView(view, title: title.value)
    setupView(view, isSelected: isSelected.value)
    setupView(view, appearance: appearanceService.getCurrentAppearance())
  }
  
  override func setupCellViewActions(_ view: ViewType) {
    view.tapAction = tapAction
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
  private func setupView(_ view: ViewType, isSelected: Bool) {
    view.setCheckImage(visible: isSelected)
  }
  
  private func setupView(_ view: ViewType, appearance: Appearance) {
    view.setAppearance(appearance)
  }
  
}
