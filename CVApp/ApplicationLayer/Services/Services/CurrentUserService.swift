//
//  CurrentUserService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 14/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CurrentUserService {
  
  // MARK: - Dependencies
  
  private let currentUserCacheWorker: CurrentUserCacheWorker
  private let authTokenCacheWorker: AuthTokenCacheWorker
  
  // MARK: - Life cycle
  
  init(currentUserCacheWorker: CurrentUserCacheWorker,
       authTokenCacheWorker: AuthTokenCacheWorker) {
    self.currentUserCacheWorker = currentUserCacheWorker
    self.authTokenCacheWorker = authTokenCacheWorker
  }
  
  // MARK: - User handling
  
  func saveCurrentUser(_ user: User) {
    currentUserCacheWorker.saveUser(user)
  }
  
  func getCurrentUser() -> User? {
    return currentUserCacheWorker.fetchCurrentUser()
  }
  
  // MARK: - Auth token handling
  
  func saveAuthToken(_ token: String) {
    authTokenCacheWorker.saveToken(token)
  }
  
  func getAuthToken() -> String? {
    return authTokenCacheWorker.fetchToken()
  }
  
  func cleanCurrentUserData() {
    currentUserCacheWorker.removeCurrentUser()
    authTokenCacheWorker.removeToken()
  }
}
