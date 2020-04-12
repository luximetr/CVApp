//
//  ServiceResultConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ServiceResultConvertor {
  
  func toServiceResult<T>(_ webAPIResult: WebAPIResult<T>) -> ServiceResult<T> {
    switch webAPIResult {
    case .success(let value):
      return .success(value)
    case .failure(let error):
      let serviceError = ServiceError(message: error.message)
      return .failure(serviceError)
    }
  }
}
