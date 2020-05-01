//
//  ChangeCVUserRoleService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeCVUserRoleService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let changeRoleWebAPIWorker: ChangeCVUserRoleWebAPIWorker
  private let cvUserRoleChangedNotifier: CVUserRoleChangedNotifier
  private let cvCacheWorker: CurrentUserCVCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       changeRoleWebAPIWorker: ChangeCVUserRoleWebAPIWorker,
       cvUserRoleChangedNotifier: CVUserRoleChangedNotifier,
       cvCacheWorker: CurrentUserCVCacheWorker) {
    self.currentUserService = currentUserService
    self.changeRoleWebAPIWorker = changeRoleWebAPIWorker
    self.cvUserRoleChangedNotifier = cvUserRoleChangedNotifier
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Change role
  
  func changeRole(cvId: CVIdType, role: String, completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    changeRoleWebAPIWorker.changeUserRole(authToken: authToken, cvId: cvId, role: role, completion: { [weak self] webAPIResult in
      switch webAPIResult {
      case .success:
        self?.cvCacheWorker.updateCVUserRole(cvId, role: role, completion: {})
        DispatchQueue.main.async {
          self?.cvUserRoleChangedNotifier.notifyCVUserRoleChanged(role)
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
  
  // MARK: - Get authToken
  
  private func getAuthToken(completion: @escaping Completion) -> String? {
    guard let token = currentUserService.getAuthToken() else {
      let error = ServiceError(message: "Can not fetch authToken at \(self)")
      completion(.failure(error))
      return nil
    }
    return token
  }
  
  // MARK: - Observers
  
  func addObserver(_ observer: CVUserRoleChangedObserver) {
    cvUserRoleChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
