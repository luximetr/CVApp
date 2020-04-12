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
  
  func createRequest(endpoint: String) -> URLRequest {
    let url = URL(string: baseURL + "/" + endpoint)!
    var request = URLRequest(url: url)
    request.addValue("Content-Type", forHTTPHeaderField: "application/json")
    return request
  }
}
