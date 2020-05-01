//
//  ChangeCVUserNameWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeCVUserNameWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Change user name
  
  func changeUserName(authToken: String, cvId: CVIdType, name: String, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken, cvId: cvId, name: name)
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        if let success = json["success"] as? Bool {
          if success {
            completion(.success(nil))
          } else {
            
          }
        }
      } else {
        
      }
    })
    task.resume()
  }
  
  // MARK: - Create request
  
  private func createRequest(authToken: String, cvId: CVIdType, name: String) -> URLRequest {
    return createURLRequest(
      endpoint: "changeUserName",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ],
      params: [
        "cvId": cvId,
        "name": name
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<Any?>) -> Void
}
