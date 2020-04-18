//
//  SkillSubitemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillSubitemCellConfigurator: ContainerTableCellConfigurator<SkillSubitemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "skillSubitemCell" }
  
  // MARK: - Data
  
  let title: Bindable<String>
  
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
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, title: title.value)
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
}
