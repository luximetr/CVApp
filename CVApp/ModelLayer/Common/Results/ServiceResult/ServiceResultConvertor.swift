//
//  ServiceResultConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ServiceResultConvertor {
  
  // MARK: - WebAPIResult -> ServiceResult
  
  func toServiceResult<T>(_ webAPIResult: WebAPIResult<T>) -> ServiceResult<T> {
    switch webAPIResult {
    case .success(let value):
      return .success(value)
    case .failure(let failure):
      let serviceError = toServiceError(failure)
      return .failure(serviceError)
    }
  }
  
  // MARK: - WebAPIFailure -> ServiceError
  
  private func toServiceError(_ failure: WebAPIFailure) -> ServiceError {
    switch failure {
    case .request(let requestError):
      return ServiceError(message: requestError.message)
    case .response(let responseError):
      return ServiceError(message: responseError.message)
    }
  }
}
