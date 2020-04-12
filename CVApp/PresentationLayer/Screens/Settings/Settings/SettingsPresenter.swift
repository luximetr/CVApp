//
//  SettingsPresenter.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SettingsPresenterOutput {
  func didTapOnChangeName(sourceVC: UIViewController)
}

class SettingsPresenter: SettingsVCOutput {
  
  weak var screen: (UIViewController & SettingsVCInput)!
  var output: SettingsPresenterOutput!
  
  func didTapOnAction(_ action: SettingsActions) {
    switch action {
    case .changeAvatar: break
    case .changeName:
      output.didTapOnChangeName(sourceVC: screen)
    case .language: break
    case .theme: break
    }
  }
}
