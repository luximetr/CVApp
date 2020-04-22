//
//  UploadFileWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 21/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class UploadFileWebAPIWorker: URLSessionWebAPIWorker {
  
  func uploadFile(image: UIImage, completion: @escaping Completion) {
    let url = URL(string: "https://us-central1-cvapp-8ebd9.cloudfunctions.net/uploadImage")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = image.jpegData(compressionQuality: 1)
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
