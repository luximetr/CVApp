//
//  AuthConfirmOTPWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthConfirmOTPWebAPIWorker: URLSessionWebAPIWorker {
  
  private let userJSONConvertor = UserJSONConvertor()
  
  func confirmOTP(code: String, completion: @escaping Completion) {
    let request = createRequest(code: code)
    let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
        if let userJSON = json["user"] as? JSON,
          let user = self?.userJSONConvertor.toUser(json: userJSON),
          let authToken = json["token"] as? String {
          completion(.success((user, authToken)))
        }
      } else {
        
      }
    })
    task.resume()
  }
  
  private func createRequest(code: String) -> URLRequest {
    var request = requestComposer.createRequest(endpoint: "authConfirmOTP")
    request.httpMethod = "POST"
    let data = [
      "code": code
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: data)
    return request
  }
  
  typealias ResponseData = (user: User, authToken: String)
  typealias Completion = (WebAPIResult<ResponseData>) -> Void
}
