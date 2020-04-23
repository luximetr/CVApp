//
//  UserDetailsItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class UserDetailsItemCellConfigurator: ContainerTableCellConfigurator<UserDetailsItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "userDetailsCell" }
  
  // MARK: - Data
  
  let avatarURL: Bindable<URL?>
  let name: Bindable<String>
  let role: Bindable<String>
  var tapAction: VoidAction?
  
  // MARK: - Services
  
  var imageSetService: ImageSetFromURLService?
  
  // MARK: - Life cycle
  
  override init() {
    avatarURL = Bindable(nil)
    name = Bindable("")
    role = Bindable("")
    super.init()
    bindView()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    avatarURL.bind(listener: { [weak self] avatarURL in
      guard let view = self?.findView() else { return }
      self?.setupView(view, avatarURL: avatarURL)
    })
    name.bind(listener: { [weak self] name in
      guard let view = self?.findView() else { return }
      self?.setupView(view, name: name)
    })
    role.bind(listener: { [weak self] role in
      guard let view = self?.findView() else { return }
      self?.setupView(view, role: role)
    })
  }
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, avatarURL: avatarURL.value)
    setupView(view, name: name.value)
    setupView(view, role: role.value)
  }
  
  private func setupView(_ view: ViewType, avatarURL: URL?) {
    imageSetService?.setImage(imageView: view.avatarView.imageView, imageURL: avatarURL)
  }
  
  private func setupView(_ view: ViewType, name: String) {
    view.nameLabel.text = name
  }
  
  private func setupView(_ view: ViewType, role: String) {
    view.roleLabel.text = role
  }
  
  // MARK: - Setup view - Actions
  
  override func setupCellViewActions(_ view: ViewType) {
    super.setupCellViewActions(view)
    view.tapAction = tapAction
  }
}
