//
//  ChangeAvatarCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeAvatarCellConfigurator: ContainerTableCellConfigurator<ChangeNameItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "changeNameItemCell" }
  var shortTitle: Bindable<String>
  var imageURL: Bindable<URL?>
  
  // MARK: - Life cycle
  
  init(shortTitle: String, imageURL: URL?) {
    self.shortTitle = Bindable(shortTitle)
    self.imageURL = Bindable(imageURL)
    super.init()
    bindData()
  }
  
  // MARK: - Bind data
  
  private func bindData() {
    shortTitle.bind(listener: { [weak self] shortTitle in
      guard let view = self?.findView() else { return }
      self?.setupView(view, shortTitle: shortTitle)
    })
    imageURL.bind(listener: { [weak self] imageURL in
      guard let view = self?.findView() else { return }
      self?.setupView(view, imageURL: imageURL)
    })
  }
  
  // MARK: - Setup view UI
  
  override func setupCellViewUI(_ view: ViewType) {
    setupView(view, imageURL: imageURL.value)
    setupView(view, shortTitle: shortTitle.value)
  }
  
  private func setupView(_ view: ViewType, imageURL: URL?) {
    
  }
  
  private func setupView(_ view: ViewType, shortTitle: String) {
    view.avatarView.shortTitleLabel.text = shortTitle
  }
}
