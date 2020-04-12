//
//  AuthPhoneInputScreenConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthPhoneInputScreenConfigurator {
  
  func createConfigured(
      requestOTPService: RequestOTPService) -> AuthPhoneInputVC {
    let view = AuthPhoneInputView()
    let vc = AuthPhoneInputVC(view: view)
    vc.requestOTPService = requestOTPService
    return vc
  }
}
