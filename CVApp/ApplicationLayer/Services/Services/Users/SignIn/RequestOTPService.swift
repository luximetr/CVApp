//
//  RequestOTPService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class RequestOTPService {
  
  // MARK: - Dependencies
  
  private let webAPIWorker: RequestOTPWebAPIWorker
  
  // MARK: - Life cycle
  
  init(webAPIWorker: RequestOTPWebAPIWorker) {
    self.webAPIWorker = webAPIWorker
  }
  
  // MARK: - Request OTP
  
  func requestOTP(phoneNumber: String, completion: @escaping Completion) {
    webAPIWorker.requestOTP(phoneNumber: phoneNumber, completion: { webAPIResult in
      DispatchQueue.main.async {
        let result = ServiceResultConvertor().toServiceResult(webAPIResult)
        completion(result)
      }
    })
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}


