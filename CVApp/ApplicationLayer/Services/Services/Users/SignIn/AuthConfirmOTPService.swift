//
//  AuthConfirmOTPService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthConfirmOTPService {
  
  // MARK: - Dependencies
  
  private let webAPIWorker: AuthConfirmOTPWebAPIWorker
  private let currentUserService: CurrentUserService
  
  // MARK: - Life cycle
  
  init(webAPIWorker: AuthConfirmOTPWebAPIWorker,
       currentUserService: CurrentUserService) {
    self.webAPIWorker = webAPIWorker
    self.currentUserService = currentUserService
  }
  
  // MARK: - Confirm OTP
  
  func confirmOTP(code: String, completion: @escaping Completion) {
    webAPIWorker.confirmOTP(code: code, completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success(let authToken):
          self?.currentUserService.saveAuthToken(authToken)
          DispatchQueue.main.async {
            completion(.success(nil))
          }
        case .failure(let failure):
          DispatchQueue.main.async {
            let error = ServiceErrorConvertor().toError(failure: failure)
            completion(.failure(error))
          }
        }
    })
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
