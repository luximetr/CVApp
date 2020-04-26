//
//  ImageFileConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ImageFileConvertor {
  
  // MARK: - Dependencies
  
  private let imageScaler = ImageScaler()
  
  // MARK: - ImageFile -> Data
  
  func toData(imageFile: ImageFile) -> Data? {
    switch imageFile {
    case .local(let file):
      return toData(localFile: file)
    case .temp(let file):
      return toData(tempFile: file)
    }
  }
  
  // MARK: - LocalFile -> Data
  
  private func toData(localFile: LocalFile) -> Data? {
    guard let fileData = try? Data(contentsOf: localFile.localURL) else { return nil }
    if let image = UIImage(data: fileData),
        getCanCompress(mimeType: localFile.mimeType) {
      let scaledImage = downscaleImage(image)
      switch localFile.mimeType.subtype {
      case "jpeg", "jpg": return scaledImage.jpegData(compressionQuality: 0.7)
      case "png": return scaledImage.pngData()
      default: return fileData
      }
    } else {
      return try? Data(contentsOf: localFile.localURL)
    }
  }
  
  private func getCanCompress(mimeType: MimeType) -> Bool {
    switch mimeType.subtype {
    case "jpeg", "jpg", "png": return true
    default: return false
    }
  }
  
  private func downscaleImage(_ image: UIImage) -> UIImage {
    return imageScaler.scaleImage(image, biggestSideMaxSize: 1000)
  }
  
  private func getJPEGData(image: UIImage) -> Data? {
    return image.jpegData(compressionQuality: 0.7)
  }
  
  private func getPNGData(image: UIImage) -> Data? {
    return image.pngData()
  }
  
  // MARK: - TempImageFile -> Data
  
  private func toData(tempFile: TempImageFile) -> Data? {
    return tempFile.value.jpegData(compressionQuality: 1)
  }
}
