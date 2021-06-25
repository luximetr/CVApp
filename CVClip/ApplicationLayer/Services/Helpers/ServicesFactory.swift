//
//  ServicesFactory.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 25.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit


class ServicesFactory {
  
  // MARK: - Dependencies
  
  private let application: UIApplication
  
  // MARK: - Life cycle
  
  init(application: UIApplication) {
    self.application = application
  }
  
  // MARK: - Start
  
  func createFirstScreenService(window: UIWindow) -> FirstScreenService {
    return FirstScreenService(
      window: window,
      servicesFactory: self)
  }
  
}
