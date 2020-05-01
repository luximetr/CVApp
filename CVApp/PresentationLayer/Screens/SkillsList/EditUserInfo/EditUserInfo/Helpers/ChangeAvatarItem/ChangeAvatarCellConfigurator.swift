//
//  ChangeAvatarCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeAvatarCellConfigurator: ContainerTableCellConfigurator<ChangeAvatarItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "changeAvatarItemCell" }
  
  // MARK: - Data
  
  let shortTitle: Bindable<String>
  let imageURL: Bindable<URL?>
  var tapEditAction: VoidAction?
  
  // MARK: - Dependencies
  
  var imageSetService: ImageSetFromURLService?
  
  // MARK: - Life cycle
  
  override init() {
    self.shortTitle = Bindable("")
    self.imageURL = Bindable(nil)
    super.init()
    bindView()
  }
  
  // MARK: - Bind data
  
  private func bindView() {
    shortTitle.bind(listener: { [weak self] shortTitle in
      guard let view = self?.findView() else { return }
      self?.setupView(view, shortTitle: shortTitle)
    })
    imageURL.bind(listener: { [weak self] imageURL in
      guard let view = self?.findView() else { return }
      self?.setupView(view, imageURL: imageURL)
    })
  }
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, imageURL: imageURL.value)
    setupView(view, shortTitle: shortTitle.value)
  }
  
  private func setupView(_ view: ViewType, imageURL: URL?) {
    imageSetService?.setImage(imageView: view.avatarView.imageView, imageURL: imageURL)
  }
  
  private func setupView(_ view: ViewType, shortTitle: String) {
    view.avatarView.shortTitleLabel.text = shortTitle
  }
  
  // MARK: - Setup view - Actions
  
  override func setupCellViewActions(_ view: ViewType) {
    super.setupCellViewActions(view)
    view.tapEditAction = tapEditAction
  }
}
