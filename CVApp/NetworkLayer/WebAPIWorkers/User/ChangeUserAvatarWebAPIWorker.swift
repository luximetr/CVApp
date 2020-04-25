//
//  ChangeUserAvatarWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ChangeUserAvatarWebAPIWorker: URLSessionWebAPIWorker {
  
  func changeAvatar(authToken: String, mimeType: String, data: Data, completion: @escaping Completion) {
    let url = URL(string: "https://us-central1-cvapp-8ebd9.cloudfunctions.net/changeUserAvatar?mimeType=\(mimeType)")!
    var request = URLRequest(url: url)
    request.addValue(authToken, forHTTPHeaderField: "authToken")
    request.httpMethod = "POST"
    request.httpBody = data
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
        if let urlString = json["url"] as? String,
          let url = URL(string: urlString) {
          completion(.success(url))
        }
      }
    }
    task.resume()
  }
  
  typealias Completion = (WebAPIResult<URL>) -> Void
}
