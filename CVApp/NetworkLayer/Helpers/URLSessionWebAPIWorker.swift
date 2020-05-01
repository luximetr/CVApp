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
  private let webAPIJSONConvertor = WebAPIErrorJSONConvertor()
  
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
    return createURLRequest(
      endpoint: endpoint,
      httpMethod: httpMethod,
      customHeaders: customHeaders,
      body: try? JSONSerialization.data(withJSONObject: params))
  }
  
  func createURLRequest(
      endpoint: String,
      httpMethod: String,
      customHeaders: [String: String] = [:],
      body: Data?) -> URLRequest {
    var request = requestComposer.createRequest(endpoint: endpoint, customHeaders: customHeaders)
    request.httpMethod = httpMethod
    request.httpBody = body
    return request
  }
  
  // MARK: - Parse webAPIError
  
  func parseWebAPIError(json: JSON) -> WebAPIError? {
    guard let errorJSON = json["error"] as? JSON else { return nil }
    return webAPIJSONConvertor.toWebAPIError(json: errorJSON)
  }
  
  func parseAnyWebAPIError(json: JSON) -> WebAPIError {
    return parseWebAPIError(json: json) ?? WebAPIErrorFactory().createUnknown()
  }
}
