//
//  GetNetworkCVWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 09.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

class GetNetworkCVWebAPIWorker: URLSessionWebAPIWorker {
    
    // MARK: - Dependencies
    
    private let cvJSONConvertor = CVJSONConvertor()
    
    // MARK: - Get CV
    
    func getCVs(cvId: CVIdType, completion: @escaping Completion) {
        let request = createRequest(cvId: cvId)
        let task = session.dataTask(
          with: request,
          completionHandler: { [weak self] data, response, error in
            guard let strongSelf = self else { return }
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
              if let json = json["data"] as? JSON,
                 let cv = strongSelf.cvJSONConvertor.toCV(json: json) {
                completion(.success(cv))
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
    
    private func createRequest(cvId: CVIdType) -> URLRequest {
      return createURLRequest(
        endpoint: "getNetworkCV",
        httpMethod: "POST",
        params: ["id": cvId]
      )
    }
    
    // MARK: - Typealiases
    
    typealias Completion = (WebAPIResult<CV>) -> Void
}
