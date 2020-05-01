//
//  ChangeCVUserRoleWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 24/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeCVUserRoleWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Change user role
  
  func changeUserRole(authToken: String, cvId: CVIdType, role: String, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken, cvId: cvId, role: role)
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        if let success = json["success"] as? Bool, success {
          completion(.success(nil))
        } else {
          
        }
      } else {
        
      }
    })
    task.resume()
  }
  
  // MARK: - Create request
  
  private func createRequest(authToken: String, cvId: CVIdType, role: String) -> URLRequest {
    return createURLRequest(
      endpoint: "changeUserRole",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ],
      params: [
        "cvId": cvId,
        "role": role
      ]
    )
  }
  
  typealias Completion = (WebAPIResult<Any?>) -> Void
}
