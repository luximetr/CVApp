//
//  SignOutService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class SignOutService {
  
  // MARK: - Dependencies
  
  private let currentUserService: CurrentUserService
  private let currentUserCVCacheWorker: CurrentUserCVCacheWorker
  private let networkCVCacheWorker: NetworkCVCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService,
       currentUserCVCacheWorker: CurrentUserCVCacheWorker,
       networkCVCacheWorker: NetworkCVCacheWorker) {
    self.currentUserService = currentUserService
    self.currentUserCVCacheWorker = currentUserCVCacheWorker
    self.networkCVCacheWorker = networkCVCacheWorker
  }
  
  // MARK: - SignOut
  
  func signOutCurrentUser() {
    currentUserService.cleanCurrentUserData()
    currentUserCVCacheWorker.removeAll()
    networkCVCacheWorker.removeAll()
  }
}
