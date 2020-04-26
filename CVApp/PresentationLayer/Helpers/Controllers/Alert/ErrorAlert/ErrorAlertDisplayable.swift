//
//  ErrorAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol ErrorAlertDisplayable: PopupAlertDisplayable {
  func showRepeatErrorAlert(message: String, onRepeat: (() -> Void)?)
}

extension ErrorAlertDisplayable where Self: ScreenController {
  
  func showRepeatErrorAlert(message: String, onRepeat: (() -> Void)?) {
    let cancelAction = AlertAction(
      title: getLocalizedString(key: "error_alert.cancel"),
      action: {},
      style: .normal)
    let repeatAction = AlertAction(
      title: getLocalizedString(key: "error_alert.repeat"),
      action: { onRepeat?() },
      style: .normal)
    let actions = [cancelAction, repeatAction]
    let viewModel = AlertViewModel(
      title: getLocalizedString(key: "error_alert.title"),
      message: message,
      actions: actions)
    showPopupAlert(viewModel: viewModel)
  }
  
}
