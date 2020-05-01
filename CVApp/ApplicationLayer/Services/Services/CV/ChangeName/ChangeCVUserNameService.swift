//
//  ChangeCVUserNameService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeCVUserNameService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let changeUserNameWebAPIWorker: ChangeCVUserNameWebAPIWorker
  private let currentUserNameChangedNotifier: CVUserNameChangedNotifier
  private let cvCacheWorker: CurrentUserCVCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       changeUserNameWebAPIWorker: ChangeCVUserNameWebAPIWorker,
       currentUserNameChangedNotifier: CVUserNameChangedNotifier,
       cvCacheWorker: CurrentUserCVCacheWorker) {
    self.currentUserService = currentUserService
    self.changeUserNameWebAPIWorker = changeUserNameWebAPIWorker
    self.currentUserNameChangedNotifier = currentUserNameChangedNotifier
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Change current user name
  
  func changeCVUserName(cvId: CVIdType, name: String, completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    changeUserNameWebAPIWorker.changeUserName(
      authToken: authToken,
      cvId: cvId,
      name: name,
      completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success:
          self?.cvCacheWorker.updateCVUserName(cvId, name: name, completion: {})
          DispatchQueue.main.async {
            self?.currentUserNameChangedNotifier.notifyCurrentUserNameChanged(name)
            completion(.success(nil))
          }
        case .failure(let error):
          DispatchQueue.main.async {
            let error = ServiceError(message: error.message)
            completion(.failure(error))
          }
        }
    })
  }
  
  private func getAuthToken(completion: @escaping Completion) -> String? {
    guard let authToken = currentUserService.getAuthToken() else {
      let error = ServiceError(message: "Can not fetch authToken at \(self)")
      completion(.failure(error))
      return nil
    }
    return authToken
  }
  
  // MARK: - Observers
  
  func addObserver(_ observer: CVUserNameChangedObserver) {
    currentUserNameChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
