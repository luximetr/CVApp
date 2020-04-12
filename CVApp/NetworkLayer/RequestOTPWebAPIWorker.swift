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
    session.dataTask(with: request, completionHandler: { data, response, error in
      print(data)
      print(response)
      print(error)
    })
  }
  
  private func createRequest(phoneNumber: String) -> URLRequest {
    var request = requestComposer.createRequest(endpoint: "requestOTP")
    let data = [
      "phone": phoneNumber
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: data)
    return request
  }
}

typealias AuthWebAPIWorkerCompletion = (WebAPIResult<Any?>) -> Void
