//
//  ImageScaler.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ImageScaler {
  
  func scaleImage(_ sourceImage: UIImage, scale: CGFloat) -> UIImage {
      let newHeight = sourceImage.size.height * scale
      let newWidth = sourceImage.size.width * scale
      
      let newSize = CGSize(width: newWidth.rounded(.down), height: newHeight.rounded(.down))
      
      UIGraphicsBeginImageContext(newSize)
      sourceImage.draw(in: CGRect(origin: .zero, size: newSize))
      guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
          return sourceImage
      }
      return resizedImage
  }
  
  func scaleImage(_ sourceImage: UIImage, biggestSideMaxSize: CGFloat) -> UIImage {
      let biggestSideSize = max(sourceImage.size.height, sourceImage.size.width)
      guard biggestSideMaxSize < biggestSideSize else { return sourceImage }
      let scale = biggestSideMaxSize / biggestSideSize
      return scaleImage(sourceImage, scale: scale)
  }
  
}
