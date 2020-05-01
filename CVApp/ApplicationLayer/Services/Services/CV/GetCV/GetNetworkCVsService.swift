//
//  GetNetworkCVsService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class GetNetworkCVsService {
  
  // MARK: - Dependencies
  
  private let getNetworkCVsWebAPIWorker: GetNetworkCVsWebAPIWorker
  private let currentUserService: CurrentUserService
  private let cvCacheWorker: NetworkCVCacheWorker
  
  // MARK: - Life cycle
  
  init(getNetworkCVsWebAPIWorker: GetNetworkCVsWebAPIWorker,
       currentUserService: CurrentUserService,
       cvCacheWorker: NetworkCVCacheWorker) {
    self.getNetworkCVsWebAPIWorker = getNetworkCVsWebAPIWorker
    self.currentUserService = currentUserService
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Get CVs
  
  func getCVs(completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    getNetworkCVsWebAPIWorker.getCVs(authToken: authToken, completion: { [weak self] result in
      switch result {
      case .success(let CVs):
        self?.cvCacheWorker.saveCVs(CVs)
        DispatchQueue.main.async {
          completion(.success(CVs))
        }
      case .failure(let failure):
        DispatchQueue.main.async {
          let error = ServiceErrorConvertor().toError(failure: failure)
          completion(.failure(error))
        }
      }
    })
  }
  
  func getCachedCVs() -> [CV] {
    return cvCacheWorker.fetchCVs() ?? []
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
  
  typealias Completion = (ServiceResult<[CV]>) -> Void
}
