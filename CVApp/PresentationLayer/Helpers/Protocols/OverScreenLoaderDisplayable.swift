//
//  OverScreenLoaderDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol OverScreenLoaderDisplayable {
  func showOverScreenLoader()
  func hideOverScreenLoader()
}

extension OverScreenLoaderDisplayable where Self: UIViewController {
  
  func showOverScreenLoader() {
    view.endEditing(true)
    SVProgressHUD.show()
  }
  
  func hideOverScreenLoader() {
    SVProgressHUD.dismiss()
  }
  
}
