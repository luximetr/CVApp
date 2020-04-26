//
//  PopupAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol PopupAlertDisplayable: SystemAlertDisplayable {
  func showPopupAlert(viewModel: AlertViewModel)
}

extension PopupAlertDisplayable {
  func showPopupAlert(viewModel: AlertViewModel) {
    showAlert(viewModel: viewModel, style: .alert)
  }
}
