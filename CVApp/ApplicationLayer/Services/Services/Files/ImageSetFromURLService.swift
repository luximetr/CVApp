//
//  ImageSetFromURLService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SDWebImage

class ImageSetFromURLService {
  
  func setImage(imageView: UIImageView, imageURL: URL?) {
    if let imageURL = imageURL {
      if imageURL.isFileURL {
        guard let data = try? Data(contentsOf: imageURL) else { return }
        if let gifImage = UIImage.sd_image(withGIFData: data) {
          imageView.image = gifImage
        } else if let image = UIImage(data: data){
          imageView.image = image
        }
      } else {
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(
          with: imageURL, placeholderImage: nil, options: [.refreshCached])
      }
    } else {
      imageView.image = nil
    }
  }
}
