//
//  RequestOTPWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class RequestOTPWebAPIWorker: URLSessionWebAPIWorker {
  
  func requestOTP(phoneNumber: String, completion: @escaping AuthWebAPIWorkerCompletion) {
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
  
  private func createRequest(phoneNumber: String) -> URLRequest {
    var request = requestComposer.createRequest(endpoint: "requestOTP")
    request.httpMethod = "POST"
    let data = [
      "phone": phoneNumber
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: data)
    return request
  }
}

typealias AuthWebAPIWorkerCompletion = (WebAPIResult<Any?>) -> Void
