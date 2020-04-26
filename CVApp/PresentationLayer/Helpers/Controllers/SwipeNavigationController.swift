//
//  SwipeNavigationController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SwipeNavigationController: UINavigationController, UIGestureRecognizerDelegate {
  
  // MARK: - Life cycle
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setNavigationBarHidden(true, animated: false)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - View - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.isEnabled = true
    interactivePopGestureRecognizer?.delegate = self
  }
  
  // MARK: - UIGestureRecognizerDelegate
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      if interactivePopGestureRecognizer == gestureRecognizer {
          return viewControllers.count > 1
      }
      return true
  }
}
