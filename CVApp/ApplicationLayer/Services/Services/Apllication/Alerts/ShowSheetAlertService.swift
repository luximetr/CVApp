//
//  ShowSheetAlertService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 2/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ShowSheetAlertService: ShowSystemAlertService {
  
  func showSheetAlert(viewModel: AlertViewModel, in vc: UIViewController) {
    showAlert(viewModel: viewModel, style: .actionSheet, in: vc)
  }
}
