//
//  SystemAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SystemAlertDisplayable {
  func showAlert(viewModel: AlertViewModel, style: UIAlertController.Style)
}

extension SystemAlertDisplayable where Self: UIViewController {
  
  func showAlert(viewModel: AlertViewModel, style: UIAlertController.Style) {
    let alert = createAlertController(viewModel: viewModel, style: style)
    self.showScreen(alert, animation: .present)
  }
  
  private func createAlertController(
      viewModel: AlertViewModel,
      style: UIAlertController.Style) -> UIAlertController {
    let alert = UIAlertController(
      title: viewModel.title,
      message: viewModel.message,
      preferredStyle: style)
    let actions = toUIAlertActions(viewModel.actions)
    actions.forEach { alert.addAction($0) }
    return alert
  }
  
  private func toUIAlertActionStyle(_ style: AlertAction.Style) -> UIAlertAction.Style {
    switch style {
    case .normal: return .default
    case .highlighted: return .cancel
    case .destructive: return .destructive
    }
  }
  
  private func toUIAlertActions(_ actions: [AlertAction]) -> [UIAlertAction] {
    return actions.map { action -> UIAlertAction in
      let style = toUIAlertActionStyle(action.style)
      return UIAlertAction(
        title: action.title,
        style: style,
        handler: { _ in
          action.action()
      })
    }
  }
  
}
