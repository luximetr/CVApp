//
//  ServicesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ServicesFactory {
  
  let webAPIWorkersFactory: WebAPIWorkersFactory
  
  init() {
    self.webAPIWorkersFactory = WebAPIWorkersFactory()
  }
  
  func createSettingsService() -> SettingsService {
    return SettingsService()
  }
  
  // MARK: - Auth
  
  func createAuthRequestOTPService() -> RequestOTPService {
    return RequestOTPService(
      webAPIWorker: webAPIWorkersFactory.createRequestOTPWorker())
  }
  
  func createAuthConfirmOTPService() -> AuthConfirmOTPService {
    return AuthConfirmOTPService(
      webAPIWorker: webAPIWorkersFactory.createAuthConfirmOTPWorker())
  }
}
