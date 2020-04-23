//
//  LocalImageFileConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class LocalImageFileConvertor {
  
  // MARK: - Dependencies
  
  private let urlDataFetcher = URLDataFetcher()
  
  // MARK: - To File

  func toFile(info: [UIImagePickerController.InfoKey: Any]) -> LocalFile? {
    guard let imageURL = info[.imageURL] as? URL else { return nil }
    let fileExtension = urlDataFetcher.fetchFileExtension(url: imageURL)
    let fileName = urlDataFetcher.fetchFileName(url: imageURL)
    let mimeType = MimeType(type: "image", subtype: fileExtension)
    
    return LocalFile(mimeType: mimeType, name: fileName, localURL: imageURL)
  }
  
}
