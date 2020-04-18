//
//  RequestOTPWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class RequestOTPWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Request OTP
  
  func requestOTP(phoneNumber: String, completion: @escaping Completion) {
    let request = createRequest(phoneNumber: phoneNumber)
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        if let result = json["result"] as? String,
          result == "success" {
          completion(.success(nil))
        }
      } else {
        
      }
    })
    task.resume()
  }
  
  // MARK: - Create request
  
  private func createRequest(phoneNumber: String) -> URLRequest {
    return createURLRequest(
      endpoint: "requestOTP",
      httpMethod: "POST",
      params: [
        "phone": phoneNumber
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<Any?>) -> Void
}
