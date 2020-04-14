//
//  AuthConfirmOTPService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthConfirmOTPService {
  
  private let webAPIWorker: AuthConfirmOTPWebAPIWorker
  
  init(webAPIWorker: AuthConfirmOTPWebAPIWorker) {
    self.webAPIWorker = webAPIWorker
  }
  
  func confirmOTP(code: String, completion: @escaping Completion) {
    webAPIWorker.confirmOTP(code: code, completion: { webAPIResult in
      DispatchQueue.main.async {
        switch webAPIResult {
        case .success(let data):
          print(data.authToken)
          completion(.success(data.user))
        case .failure(let error):
          completion(.failure(ServiceError(message: error.message)))
        }
      }
    })
  }
  
  typealias Completion = (ServiceResult<User>) -> Void
}
