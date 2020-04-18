//
//  AuthConfirmOTPWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 12/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AuthConfirmOTPWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Dependencies
  
  private let userJSONConvertor = UserJSONConvertor()
  
  // MARK: - Confirm OTP
  
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
  
  // MARK: - Create request
  
  private func createRequest(code: String) -> URLRequest {
    return createURLRequest(
      endpoint: "authConfirmOTP",
      httpMethod: "POST",
      params: [
        "code": code
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias ResponseData = (user: User, authToken: String)
  typealias Completion = (WebAPIResult<ResponseData>) -> Void
}
