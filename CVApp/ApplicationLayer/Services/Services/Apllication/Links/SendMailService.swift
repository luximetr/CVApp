//
//  SendMailService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 27/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class SendMailService {
  
  // MARK: - Dependencies
  
  private let openLinkService: OpenLinkExternallyService
  
  // MARK: - Life cycle
  
  init(openLinkService: OpenLinkExternallyService) {
    self.openLinkService = openLinkService
  }
  
  // MARK: - Send mail
  
  func sendMail(to mail: String) {
    let mailPath = "mailto:\(mail)"
    guard let url = URL(string: mailPath) else { return }
    openLinkService.openURL(url)
  }
}
