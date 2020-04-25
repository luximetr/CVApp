 //
//  ChangeUserAvatarService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

 class ChangeUserAvatarService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let changeAvatarWebAPIWorker: ChangeUserAvatarWebAPIWorker
  private let currentUserAvatarChangedNotifier: CurrentUserAvatarChangedNotifier
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       changeAvatarWebAPIWorker: ChangeUserAvatarWebAPIWorker,
       currentUserAvatarChangedNotifier: CurrentUserAvatarChangedNotifier) {
    self.currentUserService = currentUserService
    self.changeAvatarWebAPIWorker = changeAvatarWebAPIWorker
    self.currentUserAvatarChangedNotifier = currentUserAvatarChangedNotifier
  }
  
  // MARK: - Change avatar
  
  func changeAvatar(_ file: LocalFile, completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    guard let data = getData(file: file, completion: completion) else { return }
    changeAvatarWebAPIWorker.changeAvatar(
      authToken: authToken,
      mimeType: file.mimeType.toString(),
      data: data,
      completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success(let url):
          DispatchQueue.main.async {
            self?.currentUserAvatarChangedNotifier.notifyCurrentUserAvatarChanged(url)
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
  
  func addObserver(_ observer: CurrentUserAvatarChangedObserver) {
    currentUserAvatarChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Get data
  
  private func getData(file: LocalFile, completion: @escaping Completion) -> Data? {
    guard let data = try? Data(contentsOf: file.localURL) else {
      let error = ServiceError(message: "Can not fetch data from URL at \(self)")
      completion(.failure(error))
      return nil
    }
    return data
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
  
  typealias Completion = (ServiceResult<Any?>) -> Void
  
 }
