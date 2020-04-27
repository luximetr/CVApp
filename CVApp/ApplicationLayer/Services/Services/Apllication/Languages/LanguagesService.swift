//
//  LanguagesService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class LanguagesService {
  
  // MARK: - Dependencies
  
  private let languagesFactory: LanguagesFactory
  private let currentLanguageChangedNotifier: CurrentLanguageChangedNotifier
  private let currentLanguageCacheWorker: CurrentLanguageCacheWorker
  
  // MARK: - Data
  
  private lazy var currentLanguage = self.fetchCurrentLanguage()
  
  // MARK: - Life cycle
  
  init(currentLanguageChangedNotifier: CurrentLanguageChangedNotifier,
       currentLanguageCacheWorker: CurrentLanguageCacheWorker) {
    self.currentLanguageChangedNotifier = currentLanguageChangedNotifier
    self.currentLanguageCacheWorker = currentLanguageCacheWorker
    languagesFactory = LanguagesFactory()
  }
  
  // MARK: - Languages handling
  
  private func fetchCurrentLanguage() -> Language {
    return fetchCachedCurrentLanguage() ?? languagesFactory.createLanguage(code: .en)
  }
  
  private func fetchCachedCurrentLanguage() -> Language? {
    guard let code = currentLanguageCacheWorker.fetchCurrentLanguageCode() else { return nil }
    return languagesFactory.createLanguage(code: code)
  }
  
  func getLanguagesList() -> [Language] {
    return languagesFactory.createLanguagesList()
  }
  
  func getCurrentLanguage() -> Language {
    return currentLanguage
  }
  
  func changeCurrentLanguage(_ language: Language) {
    currentLanguage = language
    currentLanguageCacheWorker.saveCurrentLanguage(code: language.iso639_1Code)
    currentLanguageChangedNotifier.notifyCurrentLanguageChanged(language)
  }
  
  // MARK: - CurrentLanguageChanged observer
  
  func addCurrentLanguageChanged(observer: CurrentLanguageChangedObserver) {
    currentLanguageChangedNotifier.addObserver(observer)
  }
}
