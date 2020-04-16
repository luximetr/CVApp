//
//  SwipeNavigationController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SwipeNavigationController: UINavigationController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setNavigationBarHidden(true, animated: false)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
