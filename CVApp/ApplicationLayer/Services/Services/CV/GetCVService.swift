//
//  GetCVService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class GetCVService {
  
  // MARK: - Dependencies
  
  private let getCVWebAPIWorker: GetUserCVWebAPIWorker
  
  // MARK: - Life cycle
  
  init(getCVWebAPIWorker: GetUserCVWebAPIWorker) {
    self.getCVWebAPIWorker = getCVWebAPIWorker
  }
  
  // MARK: - Get CV
  
  func getCV(completion: @escaping Completion) {
    let userId = "userId"
    getCVWebAPIWorker.getUserCV(
      userId: userId,
      completion: { webAPIResult in
        switch webAPIResult {
        case .success(let cv):
          DispatchQueue.main.async {
            completion(.success(cv))
          }
        case .failure(let error):
          DispatchQueue.main.async {
            let error = ServiceError(message: error.message)
            completion(.failure(error))
          }
        }
    })
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<CV>) -> Void
}
