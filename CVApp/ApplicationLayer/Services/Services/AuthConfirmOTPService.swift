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
      DispatchQueue.main.async {
        switch webAPIResult {
        case .success(let data):
          self?.currentUserService.saveCurrentUser(data.user)
          self?.currentUserService.saveAuthToken(data.authToken)
          completion(.success(data.user))
        case .failure(let error):
          completion(.failure(ServiceError(message: error.message)))
        }
      }
    })
  }
  
  typealias Completion = (ServiceResult<User>) -> Void
}
