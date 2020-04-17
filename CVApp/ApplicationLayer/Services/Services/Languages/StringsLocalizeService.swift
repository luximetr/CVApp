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
    let currentLanguage = languagesService.getCurrentLanguage()
    switch currentLanguage.iso639_1Code {
    case .en:
      switch key {
      case "settings.title": return "Settings"
      default: return key
      }
    case .ru:
      switch key {
      case "settings.title": return "Настройки"
      default: return key
      }
    }
  }
}
