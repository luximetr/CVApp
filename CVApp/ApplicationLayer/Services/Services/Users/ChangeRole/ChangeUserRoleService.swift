//
//  ChangeUserRoleService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeUserRoleService {
  
  // MARK: - Dependencies
  
  private let changeRoleWebAPIWorker: ChangeUserRoleWebAPIWorker
  private let currentUserRoleChangedNotifier: CurrentUserRoleChangedNotifier
  
  // MARK: - Life cycle
  
  init(changeRoleWebAPIWorker: ChangeUserRoleWebAPIWorker,
       currentUserRoleChangedNotifier: CurrentUserRoleChangedNotifier) {
    self.changeRoleWebAPIWorker = changeRoleWebAPIWorker
    self.currentUserRoleChangedNotifier = currentUserRoleChangedNotifier
  }
  
  // MARK: - Change role
  
  func changeRole(_ role: String, completion: @escaping Completion) {
    let userId = "userId"
    changeRoleWebAPIWorker.changeUserRole(userId: userId, role: role, completion: { [weak self] webAPIResult in
      switch webAPIResult {
      case .success:
        DispatchQueue.main.async {
          self?.currentUserRoleChangedNotifier.notifyCurrentUserRoleChanged(role)
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
  
  // MARK: - Observers
  
  func addObserver(_ observer: CurrentUserRoleChangedObserver) {
    currentUserRoleChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
