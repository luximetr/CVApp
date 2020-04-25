//
//  URLRequestComposer.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class URLRequestComposer {
  
  let baseURL: String
  
  init(baseURL: String) {
    self.baseURL = baseURL
  }
  
  func createRequest(endpoint: String, customHeaders: [String: String]) -> URLRequest {
    let url = URL(string: baseURL + "/" + endpoint)!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    for (_, (headerKey, headerValue)) in customHeaders.enumerated() {
      request.addValue(headerValue, forHTTPHeaderField: headerKey)
    }
    return request
  }
}
