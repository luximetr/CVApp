//
//  AlertViewModel.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

struct AlertViewModel {
  let title: String
  let message: String?
  let actions: [AlertAction]
}
