//
//  URLSessionWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class URLSessionWebAPIWorker {
  
  // MARK: - Dependencies
  
  let session: URLSession
  private let requestComposer: URLRequestComposer
  
  // MARK: - Life cycle
  
  init(session: URLSession, requestComposer: URLRequestComposer) {
    self.session = session
    self.requestComposer = requestComposer
  }
  
  // MARK: - Create request
  
  func createURLRequest(
      endpoint: String,
      httpMethod: String,
      customHeaders: [String: String] = [:],
      params: [String: Any] = [:]) -> URLRequest {
    var request = requestComposer.createRequest(endpoint: endpoint, customHeaders: customHeaders)
    request.httpMethod = httpMethod
    request.httpBody = try? JSONSerialization.data(withJSONObject: params)
    return request
  }
}
