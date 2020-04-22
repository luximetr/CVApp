//
//  RemoteImageSetService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 21/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SDWebImage

class RemoteImageSetService {
  
  // MARK: - Set image
  
  func setImageAnimated(imageView: UIImageView, url: URL?) {
    imageView.sd_setImage(
      with: url,
      placeholderImage: nil)
  }
  
}
