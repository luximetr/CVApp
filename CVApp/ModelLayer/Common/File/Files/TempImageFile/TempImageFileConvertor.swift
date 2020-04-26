//
//  TempImageFileConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TempImageFileConvertore {
  
  // MARK: - To File

  func toFile(info: [UIImagePickerController.InfoKey: Any]) -> TempImageFile? {
    guard let image = info[.originalImage] as? UIImage else { return nil }
    let mimeType = MimeType(type: "image", subtype: "jpeg")
    
    return TempImageFile(mimeType: mimeType, value: image)
  }
}
