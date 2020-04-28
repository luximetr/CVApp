//
//  ProgressHUDAppearanceService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressHUDAppearanceService {
  
  func applyAppearance(_ appearance: Appearance) {
    SVProgressHUD.setBackgroundColor(appearance.background.secondary)
    SVProgressHUD.setForegroundColor(appearance.text.primary)
    SVProgressHUD.setDefaultMaskType(.black)
  }
}
