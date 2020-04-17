//
//  LanguagesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class LanguagesFactory {
  
  func createLanguage(code: ISO639_1Code) -> Language {
    switch code {
    case .ru: return createRussian()
    case .en: return createEnglish()
    }
  }
  
  func createLanguagesList() -> [Language] {
    return [
      createEnglish(),
      createRussian()
    ]
  }
  
  private func createEnglish() -> Language {
    return Language(iso639_1Code: .en, nativeName: "English")
  }
  
  private func createRussian() -> Language {
    return Language(iso639_1Code: .ru, nativeName: "Русский")
  }
}
