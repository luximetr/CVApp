//
//  ContactItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ContactItemCellConfigurator: ContainerTableCellConfigurator<ContactItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "contactCell" }
  
  // MARK: - Data
  
  private let icon: UIImage
  let title: Bindable<String>
  var tapAction: VoidAction?
  
  // MARK: - Life cycle
  
  init(icon: UIImage) {
    self.icon = icon
    title = Bindable("")
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
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, icon: icon)
    setupView(view, title: title.value)
  }
  
  private func setupView(_ view: ViewType, icon: UIImage) {
    view.imageView.image = icon
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
  // MARK: - Setup view - Actions
  
  override func setupCellViewActions(_ view: ViewType) {
    super.setupCellViewActions(view)
    view.tapAction = tapAction
  }
}
