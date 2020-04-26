 //
//  ChangeCVAvatarService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

 class ChangeCVAvatarService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let changeAvatarWebAPIWorker: ChangeCVAvatarWebAPIWorker
  private let currentUserAvatarChangedNotifier: CVAvatarChangedNotifier
  private let imageFileConvertor = ImageFileConvertor()
  private let cvCacheWorker: CVCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       changeAvatarWebAPIWorker: ChangeCVAvatarWebAPIWorker,
       currentUserAvatarChangedNotifier: CVAvatarChangedNotifier,
       cvCacheWorker: CVCacheWorker) {
    self.currentUserService = currentUserService
    self.changeAvatarWebAPIWorker = changeAvatarWebAPIWorker
    self.currentUserAvatarChangedNotifier = currentUserAvatarChangedNotifier
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Change avatar
  
  func changeAvatar(cvId: CVIdType, file: ImageFile, completion: @escaping Completion) {
    guard let authToken = getAuthToken(completion: completion) else { return }
    guard let data = getData(fileType: file, completion: completion) else { return }
    changeAvatarWebAPIWorker.changeAvatar(
      authToken: authToken,
      mimeType: file.mimeType.toString(),
      data: data,
      completion: { [weak self] webAPIResult in
        switch webAPIResult {
        case .success(let url):
          DispatchQueue.main.async {
            self?.cvCacheWorker.updateCVAvatar(cvId, avatarURL: url, completion: {})
            self?.currentUserAvatarChangedNotifier.notifyCVAvatarChanged(url)
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
  
  func addObserver(_ observer: CVAvatarChangedObserver) {
    currentUserAvatarChangedNotifier.addObserver(observer)
  }
  
  // MARK: - Get data
  
  private func getData(fileType: ImageFile, completion: @escaping Completion) -> Data? {
    guard let data = imageFileConvertor.toData(imageFile: fileType) else {
      let error = ServiceError(message: "Can not convert image to data at \(self)")
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
