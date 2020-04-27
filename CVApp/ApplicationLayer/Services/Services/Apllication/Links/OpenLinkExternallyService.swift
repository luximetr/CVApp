//
//  OpenLinkExternallyService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 27/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class OpenLinkExternallyService {
  
  // MARK: - Dependencies
  
  private let application: UIApplication
  
  // MARK: - Life cycle
  
  init(application: UIApplication) {
    self.application = application
  }
  
  // MARK: - Open URL
  
  func openURL(_ url: URL) {
    application.open(url, options: [:], completionHandler: nil)
  }
  
}
