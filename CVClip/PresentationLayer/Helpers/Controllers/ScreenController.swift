//
//  ScreenController.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 25.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

typealias ScreenView = (UIView & AppearanceConfigurable)

class ScreenController: InitViewController {
  
  // MARK: - UI elements
  
  var screenView: ScreenView
  
  // MARK: - Life cycle
  
  public init(screenView: ScreenView) {
    self.screenView = screenView
    super.init()
  }
  
}
