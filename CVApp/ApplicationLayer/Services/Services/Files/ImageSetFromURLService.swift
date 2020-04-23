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
        let data = try? Data(contentsOf: imageURL)
        let image = UIImage(data: data ?? Data())
        imageView.image = image
      } else {
        imageView.sd_setImage(with: imageURL, placeholderImage: nil)
      }
    } else {
      imageView.image = nil
    }
  }
}
