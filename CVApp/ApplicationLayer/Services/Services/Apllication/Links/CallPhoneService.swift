//
//  CallPhoneService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 27/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CallPhoneService {
  
  // MARK: - Dependencies
  
  private let openLinkService: OpenLinkExternallyService
  
  // MARK: - Life cycle
  
  init(openLinkService: OpenLinkExternallyService) {
    self.openLinkService = openLinkService
  }
  
  // MARK: - Call phone number
  
  func callPhoneNumber(_ phoneNumber: String) {
    let phoneNumberPath = "tel://" + phoneNumber
    guard let url = URL(string: phoneNumberPath) else { return }
    openLinkService.openURL(url)
  }
}
