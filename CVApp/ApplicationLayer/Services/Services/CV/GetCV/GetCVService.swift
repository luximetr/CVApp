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
  
  private let currentUserService: CurrentUserService
  private let getCVWebAPIWorker: GetUserCVWebAPIWorker
  private let cvCacheWorker: CurrentUserCVCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       getCVWebAPIWorker: GetUserCVWebAPIWorker,
       cvCacheWorker: CurrentUserCVCacheWorker) {
    self.currentUserService = currentUserService
    self.getCVWebAPIWorker = getCVWebAPIWorker
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Get CV
  
  func getCV(completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    getCVWebAPIWorker.getUserCV(
      authToken: authToken,
      completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success(let cv):
          self?.cvCacheWorker.saveCV(cv, completion: {})
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
  
  func getCachedCV() -> CV? {
    return cvCacheWorker.fetchCV()
  }
  
  // MARK: - Get authToken
  
  private func getAuthToken(completion: @escaping Completion) -> String? {
    guard let token = currentUserService.getAuthToken() else {
      let error = ServiceError(message: "Can not fetch authToken at \(self)")
      completion(.failure(error))
      return nil
    }
    return token
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<CV>) -> Void
}
