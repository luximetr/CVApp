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
    let task = session.dataTask(
      with: request,
      completionHandler: { [weak self] data, response, error in
        guard let strongSelf = self else { return }
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
          if let success = json["data"] as? Bool, success {
            completion(.success(nil))
          } else {
            let failure = strongSelf.parseFailure(json: json)
            completion(.failure(failure))
          }
        } else {
          let failure = strongSelf.parseFailure(error: error)
          completion(.failure(failure))
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
