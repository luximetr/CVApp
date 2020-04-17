//
//  StringsLocalizeService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class StringsLocalizeService {
  
  // MARK: - Dependencies
  
  private let languagesService: LanguagesService
  
  // MARK: - Life cycle
  
  init(languagesService: LanguagesService) {
    self.languagesService = languagesService
  }
  
  func getLocalizedString(key: String) -> String {
    return key
  }
}
