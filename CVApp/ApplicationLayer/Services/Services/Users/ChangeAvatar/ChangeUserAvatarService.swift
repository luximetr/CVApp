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
  
  private let changeAvatarWebAPIWorker: ChangeUserAvatarWebAPIWorker
  private let currentUserAvatarChangedNotifier: CurrentUserAvatarChangedNotifier
  
  // MARK: - Life cycle
  
  init(changeAvatarWebAPIWorker: ChangeUserAvatarWebAPIWorker,
       currentUserAvatarChangedNotifier: CurrentUserAvatarChangedNotifier) {
    self.changeAvatarWebAPIWorker = changeAvatarWebAPIWorker
    self.currentUserAvatarChangedNotifier = currentUserAvatarChangedNotifier
  }
  
  // MARK: - Change avatar
  
  func changeAvatar(_ file: LocalFile, completion: @escaping Completion) {
    let userId = "userId1"
    guard let data = getData(file: file, completion: completion) else { return }
    changeAvatarWebAPIWorker.changeAvatar(
      userId: userId,
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
  
  func addObserver(_ observer: CurrentUserAvatarChangedObserver) {
    currentUserAvatarChangedNotifier.addObserver(observer)
  }
  
  // MARK: - File to data
  
  private func getData(file: LocalFile, completion: @escaping Completion) -> Data? {
    guard let data = try? Data(contentsOf: file.localURL) else {
      let error = ServiceError(message: "Can not fetch data from URL at \(self)")
      completion(.failure(error))
      return nil
    }
    return data
  }
  
  typealias Completion = (ServiceResult<Any?>) -> Void
  
 }
