//
//  GetNetworkCVsWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class GetNetworkCVsWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Dependencies
  
  private let cvJSONConvertor = CVJSONConvertor()
  
  // MARK: - Get CVs
  
  func getCVs(authToken: String, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken)
    let task = session.dataTask(
      with: request,
      completionHandler: { [weak self] data, response, error in
        guard let strongSelf = self else { return }
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
          if let dataJSONs = json["data"] as? [JSON] {
             let CVs = dataJSONs.compactMap({ strongSelf.cvJSONConvertor.toCV(json: $0) })
            completion(.success(CVs))
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
  
  private func createRequest(authToken: String) -> URLRequest {
    return createURLRequest(
      endpoint: "getNetworkCVs",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ]
    )
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<[CV]>) -> Void
}
