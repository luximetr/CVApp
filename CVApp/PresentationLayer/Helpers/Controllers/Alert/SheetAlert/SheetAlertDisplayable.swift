//
//  SheetAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

protocol SheetAlertDisplayable: SystemAlertDisplayable {
  func showSheetAlert(viewModel: AlertViewModel)
}

extension SheetAlertDisplayable {
  func showSheetAlert(viewModel: AlertViewModel) {
    showAlert(viewModel: viewModel, style: .actionSheet)
  }
}
