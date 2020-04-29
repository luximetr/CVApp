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
  
  // MARK: - Life cycle
  
  init(changeRoleWebAPIWorker: ChangeUserRoleWebAPIWorker) {
    self.changeRoleWebAPIWorker = changeRoleWebAPIWorker
  }
  
  // MARK: - Change role
  
  func changeRole(_ role: String, completion: @escaping Completion) {
    let userId = "userId"
    changeRoleWebAPIWorker.changeUserRole(userId: userId, role: role, completion: { webAPIResult in
      switch webAPIResult {
      case .success:
        break
      case .failure(let error):
        DispatchQueue.main.async {
          let error = ServiceError(message: error.message)
          completion(.failure(error))
        }
      }
    })
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
