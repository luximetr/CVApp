//
//  WebAPIWorkersFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class WebAPIWorkersFactory {
  
  private let session: URLSession
  private let baseURL: String
  private let requestComposer: URLRequestComposer
  
  init(session: URLSession) {
    self.session = session
    baseURL = "https://us-central1-cvapp-8ebd9.cloudfunctions.net"
    requestComposer = URLRequestComposer(baseURL: baseURL)
  }
  
  // MARK: - Auth
  
  func createRequestOTPWorker() -> RequestOTPWebAPIWorker {
    return RequestOTPWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  func createAuthConfirmOTPWorker() -> AuthConfirmOTPWebAPIWorker {
    return AuthConfirmOTPWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  // MARK: - CV
  
  func getUserCVWorker() -> GetUserCVWebAPIWorker {
    return GetUserCVWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  func getNetworkCVsWorker() -> GetNetworkCVsWebAPIWorker {
    return GetNetworkCVsWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  func createChangeCVAvatarWorker() -> ChangeCVAvatarWebAPIWorker {
    return ChangeCVAvatarWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  func createChangeCVUserNameWorker() -> ChangeCVUserNameWebAPIWorker {
    return ChangeCVUserNameWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
  
  func createChangeCVUserRoleWorker() -> ChangeCVUserRoleWebAPIWorker {
    return ChangeCVUserRoleWebAPIWorker(
      session: session,
      requestComposer: requestComposer)
  }
}
