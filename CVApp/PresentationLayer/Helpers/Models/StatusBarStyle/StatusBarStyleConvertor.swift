//
//  StatusBarStyleConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class StatusBarStyleConvertor {
  
  func toUIStatusBarStyle(_ style: StatusBarStyle) -> UIStatusBarStyle {
    switch style {
    case .light: return .lightContent
    case .dark:
      if #available(iOS 13.0, *) {
        return .darkContent
      } else {
        return .default
      }
    }
  }
}
