//
//  ShowPopupAlertService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 2/5/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ShowPopupAlertService: ShowSystemAlertService {
  
  func showPopupAlert(viewModel: AlertViewModel, in vc: UIViewController) {
    showAlert(viewModel: viewModel, style: .alert, in: vc)
  }
  
}
