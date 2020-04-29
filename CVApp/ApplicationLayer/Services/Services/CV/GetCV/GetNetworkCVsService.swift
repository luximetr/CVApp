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
  
  // MARK: - Life cycle
  
  init(getNetworkCVsWebAPIWorker: GetNetworkCVsWebAPIWorker,
       currentUserService: CurrentUserService) {
    self.getNetworkCVsWebAPIWorker = getNetworkCVsWebAPIWorker
    self.currentUserService = currentUserService
  }
  
  // MARK: - Get CVs
  
  func getCVs(completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    getNetworkCVsWebAPIWorker.getCVs(authToken: authToken, completion: { result in
      switch result {
      case .success(let CVs):
        
        DispatchQueue.main.async {
          completion(.success(CVs))
        }
      case .failure(let error):
        DispatchQueue.main.async {
          let error = ServiceError(message: error.message)
          completion(.failure(error))
        }
      }
    })
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
