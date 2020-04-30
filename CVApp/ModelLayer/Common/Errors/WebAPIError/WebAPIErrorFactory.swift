//
//  WebAPIErrorFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class WebAPIErrorFactory {
  
  func createUnknown() -> WebAPIError {
    return WebAPIError(message: "Unknown error", code: .unknown)
  }
}
