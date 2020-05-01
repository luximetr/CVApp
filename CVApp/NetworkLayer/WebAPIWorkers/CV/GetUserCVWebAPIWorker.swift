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
  
  func getUserCV(authToken: String, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken)
    let task = session.dataTask(
      with: request,
      completionHandler: { [weak self] data, response, error in
        guard let strongSelf = self else { return }
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
          if let dataJSON = json["data"] as? JSON {
            if let cv = strongSelf.cvJSONConvertor.toCV(json: dataJSON) {
              completion(.success(cv))
            } else {
              
            }
          } else {
            let error = strongSelf.parseAnyWebAPIError(json: json)
            completion(.failure(error))
          }
        } else {
          
        }
    })
    task.resume()
  }
  
  // MARK: - Create request
  
  private func createRequest(authToken: String) -> URLRequest {
    return createURLRequest(
      endpoint: "getUserCV",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<CV>) -> Void
}
