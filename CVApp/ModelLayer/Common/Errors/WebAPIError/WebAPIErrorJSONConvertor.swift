//
//  WebAPIErrorJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class WebAPIErrorJSONConvertor {
  
  // MARK: - JSON -> WebAPIError
  
  func toWebAPIError(json: JSON) -> WebAPIError? {
    guard let message = json["message"] as? String else { return nil }
    let code = parseCode(json: json)
    return WebAPIError(message: message, code: code)
  }
  
  // MARK: - Parse code
  
  private func parseCode(json: JSON) -> WebAPIErrorCode {
    guard let codeRawValue = json["code"] as? WebAPIErrorCode.RawValue else { return .unknown }
    return WebAPIErrorCode(rawValue: codeRawValue) ?? .unknown
  }
}
