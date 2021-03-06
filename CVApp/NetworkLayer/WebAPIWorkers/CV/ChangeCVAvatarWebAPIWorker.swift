//
//  ChangeCVAvatarWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeCVAvatarWebAPIWorker: URLSessionWebAPIWorker {
  
  // MARK: - Change avatar
  
  func changeAvatar(authToken: String, cvId: CVIdType, mimeType: String, data: Data, completion: @escaping Completion) {
    let request = createRequest(authToken: authToken, cvId: cvId, mimeType: mimeType, data: data)
    let task = session.dataTask(
      with: request,
      completionHandler: { [weak self] (data, response, error) in
        guard let strongSelf = self else { return }
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
          if let urlString = json["data"] as? String,
             let url = URL(string: urlString) {
            completion(.success(url))
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
  
  private func createRequest(
      authToken: String,
      cvId: CVIdType,
      mimeType: String,
      data: Data) -> URLRequest {
    return createURLRequest(
      endpoint: "changeCVAvatar?cvId=\(cvId)&mimeType=\(mimeType)",
      httpMethod: "POST",
      customHeaders: [
        "authToken": authToken
      ],
      contentType: mimeType,
      body: data)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (WebAPIResult<URL>) -> Void
}
