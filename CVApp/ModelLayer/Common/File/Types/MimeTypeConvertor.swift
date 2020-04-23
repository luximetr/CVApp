//
//  MimeTypeConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class MimeTypeConvertor {
  
  // MARK: - Dependencies
  
  private let urlDataFetcher = URLDataFetcher()
  
  // MARK: - Get mime type
  
  func getMimeType(url: URL) -> MimeType? {
    let fileExtension = urlDataFetcher.fetchFileExtension(url: url)
    guard let type = getMimeTypeType(fileExtension: fileExtension) else { return nil }
    return MimeType(type: type, subtype: fileExtension)
  }
  
  private func getMimeTypeType(fileExtension: String) -> String? {
    switch fileExtension {
    case "jpeg", "jpg", "png", "gif": return "image"
    default: return nil
    }
  }
}
