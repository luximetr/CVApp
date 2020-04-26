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
      return toCompressedData(localFile: file)
    case .temp(let file):
      return toCompressedData(tempFile: file)
    }
  }
  
  // MARK: - LocalFile -> Data
  
  private func toCompressedData(localFile: LocalFile) -> Data? {
    let fileURL = localFile.localURL
    switch localFile.mimeType.subtype {
    case "jpeg", "jpg": return toCompressedJPEGData(fileURL: fileURL)
    case "png": return toCompressedPNGData(fileURL: fileURL)
    default: return getData(from: fileURL)
    }
  }
  
  // MARK: - TempImageFile -> Data
  
  private func toCompressedData(tempFile: TempImageFile) -> Data? {
    return toCompressedJPEGData(image: tempFile.value)
  }
  
  // MARK: - URL -> Data
  
  private func toCompressedJPEGData(fileURL: URL) -> Data? {
    guard let image = getImage(from: fileURL) else { return getData(from: fileURL) }
    let scaledImage = downscaleImage(image)
    return getJPEGData(image: scaledImage)
  }
  
  private func toCompressedJPEGData(image: UIImage) -> Data? {
    let scaledImage = downscaleImage(image)
    return getJPEGData(image: scaledImage)
  }
  
  private func toCompressedPNGData(fileURL: URL) -> Data? {
    guard let image = getImage(from: fileURL) else { return getData(from: fileURL) }
    let scaledImage = downscaleImage(image)
    return getPNGData(image: scaledImage)
  }
  
  private func getData(from url: URL) -> Data? {
    return try? Data(contentsOf: url)
  }
  
  // MARK: - URL -> UIImage
  
  private func getImage(from url: URL) -> UIImage? {
    guard let data = getData(from: url) else { return nil }
    return UIImage(data: data)
  }
  
  // MARK: - Downscale image
  
  private func downscaleImage(_ image: UIImage) -> UIImage {
    return imageScaler.scaleImage(image, biggestSideMaxSize: 1000)
  }
  
  // MARK: - UIImage -> Data
  
  private func getJPEGData(image: UIImage) -> Data? {
    return image.jpegData(compressionQuality: 0.7)
  }
  
  private func getPNGData(image: UIImage) -> Data? {
    return image.pngData()
  }
}
