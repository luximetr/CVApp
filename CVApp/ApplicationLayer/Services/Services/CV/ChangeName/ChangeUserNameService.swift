//
//  ChangeUserNameService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeUserNameService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let changeUserNameWebAPIWorker: ChangeUserNameWebAPIWorker
  private let currentUserNameChangedNotifier: CurrentUserNameChangedNotifier
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       changeUserNameWebAPIWorker: ChangeUserNameWebAPIWorker,
       currentUserNameChangedNotifier: CurrentUserNameChangedNotifier) {
    self.currentUserService = currentUserService
    self.changeUserNameWebAPIWorker = changeUserNameWebAPIWorker
    self.currentUserNameChangedNotifier = currentUserNameChangedNotifier
  }
  
  // MARK: - Change current user name
  
  func changeCurrentUser(name: String, completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    changeUserNameWebAPIWorker.changeUserName(
      authToken: authToken,
      name: name,
      completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success:
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
  
  func addObserver(_ observer: CurrentUserNameChangedObserver) {
    currentUserNameChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
