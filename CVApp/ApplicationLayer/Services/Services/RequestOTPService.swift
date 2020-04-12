//
//  RequestOTPService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class RequestOTPService {
  
  let webAPIWorker: RequestOTPWebAPIWorker
  
  init(webAPIWorker: RequestOTPWebAPIWorker) {
    self.webAPIWorker = webAPIWorker
  }
  
  func requestOTP(phoneNumber: String) {
    
  }
  
}

typealias RequestOTPServiceCompletion = (ServiceResult<Any?>) -> Void
