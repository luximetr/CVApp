//
//  ImageFileConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ImageFileConvertor {
  
  // MARK: - Dependencies
  
  private let imageScaler = ImageScaler()
  
  // MARK: - To data
  
  func toData(imageFile: ImageFile) -> Data? {
    switch imageFile {
    case .local(let file):
      return toData(localFile: file)
    case .temp(let file):
      return toData(tempFile: file)
    }
  }
  
  private func toData(localFile: LocalFile) -> Data? {
    return try? Data(contentsOf: localFile.localURL)
  }
  
  private func toData(tempFile: TempImageFile) -> Data? {
    return tempFile.value.jpegData(compressionQuality: 1)
  }
}
