//
//  SystemAlertDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 25/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SystemAlertDisplayable {
  func showErrorAlert(message: String, onRepeat: (() -> Void)?)
}

extension SystemAlertDisplayable where Self: UIViewController {
  
  func showErrorAlert(message: String, onRepeat: (() -> Void)? = nil) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let repeatAction = UIAlertAction(title: "Repeat", style: .default, handler: { _ in
      onRepeat?()
    })
    
    applyAlertAppearence(alert: alert)
    
    alert.addAction(cancelAction)
    alert.addAction(repeatAction)
    showScreen(alert, animation: .present)
  }
  
  private func applyAlertAppearence(alert: UIAlertController) {
    guard let vc = self as? ScreenController else { return }
    guard let appearence = vc.currentAppearanceService?.getCurrentAppearance() else { return }
    alert.setTitleColor(appearence.primaryTextColor)
    alert.setMessageColor(appearence.secondaryTextColor)
    alert.setTintColor(appearence.primaryTextColor)
    alert.setBackgroundColor(appearence.alertBackgroundColor)
  }
  
}
