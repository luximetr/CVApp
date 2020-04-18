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
  
  private let changeUserNameWebAPIWorker: ChangeUserNameWebAPIWorker
  private let currentUserNameChangedNotifier: CurrentUserNameChangedNotifier
  
  // MARK: - Life cycle
  
  init(changeUserNameWebAPIWorker: ChangeUserNameWebAPIWorker,
       currentUserNameChangedNotifier: CurrentUserNameChangedNotifier) {
    self.changeUserNameWebAPIWorker = changeUserNameWebAPIWorker
    self.currentUserNameChangedNotifier = currentUserNameChangedNotifier
  }
  
  // MARK: - Change current user name
  
  func changeCurrentUser(name: String, completion: @escaping Completion) {
    changeUserNameWebAPIWorker.changeUserName(
      userId: "userId",
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
  
  // MARK: - Observers
  
  func addChangeCurrentNameChanged(observer: CurrentUserNameChangedObserver) {
    currentUserNameChangedNotifier.addObserver(observer)
  }
  
  typealias Completion = (ServiceResult<Any?>) -> Void
}
