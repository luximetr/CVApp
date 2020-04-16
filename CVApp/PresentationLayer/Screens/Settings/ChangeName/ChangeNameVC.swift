//
//  ChangeNameVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 10/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameVC: ScreenController {
  
  override init(screenView: ScreenView) {
    super.init(screenView: screenView)
    hidesBottomBarWhenPushed = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
  }
  
  
}
