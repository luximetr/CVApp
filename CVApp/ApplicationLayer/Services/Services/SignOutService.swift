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
  
  // MARK: - Life cycle
  
  init(currentUserService: CurrentUserService) {
    self.currentUserService = currentUserService
  }
  
  // MARK: - SignOut
  
  func signOutCurrentUser() {
    currentUserService.cleanCurrentUserData()
  }
}
