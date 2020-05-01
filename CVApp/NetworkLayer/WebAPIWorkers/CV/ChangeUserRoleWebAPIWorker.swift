//
//  ChangeUserRoleWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeUserRoleWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Change user role
  
  func changeUserRole(authToken: String, role: String, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken, role: role)
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
  
  private func createRequest(authToken: String, role: String) -> URLRequest {
    return createURLRequest(
      endpoint: "changeUserRole",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ],
      params: [
        "role": role
      ]
    )
  }
  
  typealias Completion = (WebAPIResult<Any?>) -> Void
}
