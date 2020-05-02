//
//  NetworkItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkItemCellConfigurator: ContainerTableCellConfigurator<NetworkItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "networkItemCell" }
  
  // MARK: - Data
  
  let avatarURL: Bindable<URL?>
  let title: Bindable<String>
  let subtitle: Bindable<String>
  var tapAction: VoidAction?
  
  // MARK: - Services
  
  var imageSetService: ImageSetFromURLService?
  
  // MARK: - Life cycle
  
  override init() {
    self.avatarURL = Bindable(nil)
    self.title = Bindable("")
    self.subtitle = Bindable("")
    super.init()
    bindView()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    avatarURL.bind(listener: { [weak self] avatarURL in
      guard let view = self?.findView() else { return }
      self?.setupView(view, avatarURL: avatarURL)
    })
    title.bind(listener: { [weak self] title in
      guard let view = self?.findView() else { return }
      self?.setupView(view, title: title)
    })
    subtitle.bind(listener: { [weak self] subtitle in
      guard let view = self?.findView() else { return }
      self?.setupView(view, subtitle: subtitle)
    })
  }
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, avatarURL: avatarURL.value)
    setupView(view, title: title.value)
    setupView(view, subtitle: subtitle.value)
  }
  
  private func setupView(_ view: ViewType, avatarURL: URL?) {
    imageSetService?.setImage(
      imageView: view.avatarView.imageView,
      imageURL: avatarURL,
      placeholder: AssetsFactory.avatar_placeholder)
  }
  
  private func setupView(_ view: ViewType, title: String) {
    view.titleLabel.text = title
  }
  
  private func setupView(_ view: ViewType, subtitle: String) {
    view.subtitleLabel.text = subtitle
  }
  
  // MARK: - Setup view - Actions
  
  override func setupCellViewActions(_ view: ViewType) {
    super.setupCellViewActions(view)
    view.tapAction = tapAction
  }
}
