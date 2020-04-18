//
//  GetUserCVWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class GetUserCVWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Depencencies
  
  private let cvJSONConvertor = CVJSONConvertor()
  
  // MARK: - Get user CV
  
  func getUserCV(userId: UserIdType, completion: @escaping Completion) {
    let request = createRequest(userId: userId)
    let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
      guard let strongSelf = self else { return }
      if let data = data,
         let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        if let cv = strongSelf.cvJSONConvertor.toCV(json: json) {
          completion(.success(cv))
        } else {
          
        }
      } else {
        
      }
    })
    task.resume()
  }
  
  // MARK: - Create request
  
  private func createRequest(userId: String) -> URLRequest {
    return createURLRequest(
      endpoint: "getUserCV",
      httpMethod: "POST",
      params: [
        "userId": userId
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<CV>) -> Void
}