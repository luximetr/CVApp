//
//  ChangeUserNameWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeUserNameWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Change user name
  
  func changeUserName(userId: UserIdType, name: String, completion: @escaping Completion) {
    let request = createRequest(userId: userId, name: name)
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
  
  private func createRequest(userId: UserIdType, name: String) -> URLRequest {
    return createURLRequest(
      endpoint: "changeUserName",
      httpMethod: "POST",
      params: [
        "id": userId,
        "name": name
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<Any?>) -> Void
}
