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
  private let tableName: String
  
  // MARK: - Life cycle
  
  init(languagesService: LanguagesService, tableName: String) {
    self.languagesService = languagesService
    self.tableName = tableName
  }
  
  // MARK: - Get localizedString
  
  func getLocalizedString(key: String, args: [CVarArg] = []) -> String {
    let currentLanguage = languagesService.getCurrentLanguage()
    let bundle = getBundle(code: currentLanguage.iso639_1Code)
    return String(
      format: NSLocalizedString(key, tableName: tableName, bundle: bundle, value: key, comment: ""),
      arguments: args)
  }
  
  // MARK: - Find bundle
  
  private var previouslyFoundBundle: Bundle?
  
  private func getBundle(code: ISO639_1Code) -> Bundle {
    if let previouslyFoundBundle = previouslyFoundBundle,
        code.rawValue == previouslyFoundBundle.bundleIdentifier {
      return previouslyFoundBundle
    } else {
      let defaultBundle = Bundle.main
      guard let bundlePath = Bundle.main.path(forResource: code.rawValue, ofType: "lproj") else {
        return defaultBundle
      }
      return Bundle(path: bundlePath) ?? defaultBundle
    }
  }
}
