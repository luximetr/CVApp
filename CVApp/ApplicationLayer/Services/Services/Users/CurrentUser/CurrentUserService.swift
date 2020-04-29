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
  
  private let authTokenCacheWorker: AuthTokenCacheWorker
  
  // MARK: - Life cycle
  
  init(authTokenCacheWorker: AuthTokenCacheWorker) {
    self.authTokenCacheWorker = authTokenCacheWorker
  }
  
  // MARK: - Auth token handling
  
  func saveAuthToken(_ token: String) {
    authTokenCacheWorker.saveToken(token)
  }
  
  func getAuthToken() -> String? {
    return authTokenCacheWorker.fetchToken()
  }
  
  func cleanCurrentUserData() {
    authTokenCacheWorker.removeToken()
  }
}
