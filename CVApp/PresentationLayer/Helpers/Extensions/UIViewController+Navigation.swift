//
//  UIViewController+Navigation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

enum ShowScreenAnimation {
  case push
  case present
}

enum CloseScreenAnimation {
  case pop
  case dismiss
}

extension UIViewController {
  
  func showScreen(
      _ vc: UIViewController,
      animation: ShowScreenAnimation,
      animated: Bool = true,
      completion: (() -> Void)? = nil) {
    switch animation {
    case .push:
      navigationController?.pushViewController(vc, animated: animated)
    case .present:
      present(vc, animated: animated, completion: completion)
    }
  }
  
  func closeScreen(
        animation: CloseScreenAnimation,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {
    switch animation {
    case .pop:
      navigationController?.popViewController(animated: animated)
    case .dismiss:
      dismiss(animated: animated, completion: completion)
    }
  }
  
}
