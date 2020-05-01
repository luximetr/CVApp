//
//  ShowSystemAlertService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 2/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ShowSystemAlertService {
  
  // MARK: - Dependencies
  
  private let stringsLocalizeService: StringsLocalizeService
  
  // MARK: - Life cycle
  
  init(stringsLocalizeService: StringsLocalizeService) {
    self.stringsLocalizeService = stringsLocalizeService
  }
  
  // MARK: - Show alert
  
  func showAlert(viewModel: AlertViewModel, style: UIAlertController.Style, in vc: UIViewController) {
    let alert = createAlertController(viewModel: viewModel, style: style)
    vc.showScreen(alert, animation: .present)
  }
  
  // MARK: - Create alert controller
  
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
  
  // MARK: - Get localized string
  
  func getLocalizedString(key: String) -> String {
    return stringsLocalizeService.getLocalizedString(key: key)
  }
   
}
