//
//  ImageFile.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

enum ImageFile {
  
  case temp(_ file: TempImageFile)
  case local(_ file: LocalFile)
  
  var mimeType: MimeType {
    switch self {
    case .temp(let file):
      return file.mimeType
    case .local(let file):
      return file.mimeType
    }
  }
}
