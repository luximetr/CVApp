//
//  LocalFileConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class LocalFileConvertor {
  
  // MARK: - Dependencies
  
  private let imageFileConvertor = LocalImageFileConvertor()
  
  // MARK: - To File
  
  func toFile(info: [UIImagePickerController.InfoKey: Any]) -> LocalFile? {
    if let imageFile = imageFileConvertor.toFile(info: info) {
      return imageFile
    }
    return nil
  }
}
