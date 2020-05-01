//
//  AlertAction.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

struct AlertAction {
  
  let title: String
  let action: VoidAction
  let style: Style
  
  enum Style {
    case normal
    case highlighted
    case destructive
  }
}
