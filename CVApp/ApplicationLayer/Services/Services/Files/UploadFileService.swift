//
//  UploadFileService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 21/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class UploadFileService {
  
  // MARK: - Dependencies
  
  private let uploadFileWebAPIWorker: UploadFileWebAPIWorker
  
  // MARK: - Life cycle
  
  init(uploadFileWebAPIWorker: UploadFileWebAPIWorker) {
    self.uploadFileWebAPIWorker = uploadFileWebAPIWorker
  }
  
  func uploadImage(_ image: UIImage, completion: @escaping Completion) {
    uploadFileWebAPIWorker.uploadFile(image: image, completion: { result in
      switch result {
      case .success(let url):
        DispatchQueue.main.async {
          completion(.success(url))
        }
      case .failure(let error):
        DispatchQueue.main.async {
          completion(.failure(ServiceError(message: error.message)))
        }
      }
    })
  }
  
  typealias Completion = (ServiceResult<URL>) -> Void
}
