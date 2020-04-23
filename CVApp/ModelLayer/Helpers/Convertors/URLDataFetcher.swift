//
//  URLDataFetcher.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class URLDataFetcher {
  
  func fetchFileName(url: URL) -> String {
    return url.deletingPathExtension().lastPathComponent
  }
  
  func fetchFileExtension(url: URL) -> String {
    return url.pathExtension.lowercased()
  }
}
