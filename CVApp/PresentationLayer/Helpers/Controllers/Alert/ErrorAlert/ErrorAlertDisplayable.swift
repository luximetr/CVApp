//
//  ErrorAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol ErrorAlertDisplayable: PopupAlertDisplayable {
  func showErrorAlert(message: String, onRepeat: (() -> Void)?)
}

extension ErrorAlertDisplayable where Self: ScreenController {
  
  func showErrorAlert(message: String, onRepeat: (() -> Void)?) {
    let cancelAction = AlertAction(
      title: getLocalizedString(key: "error_alert.cancel"),
      action: {},
      style: .normal)
    let repeateAction = AlertAction(
      title: getLocalizedString(key: "error_alert.repeat"),
      action: { onRepeat?() },
      style: .highlighted)
    let actions = [cancelAction, repeateAction]
    let viewModel = AlertViewModel(
      title: getLocalizedString(key: "error_alert.title"),
      message: message,
      actions: actions)
    showPopupAlert(viewModel: viewModel)
  }
  
}
