//
//  IntentHandler.swift
//  CVListWidgetIntentExtension
//
//  Created by Oleksandr Orlov on 09.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Intents

class IntentHandler: INExtension, SelectCharacterIntentHandling {
  
  func resolveAvatar(for intent: SelectCharacterIntent, with completion: @escaping (AvatarResolutionResult) -> Void) {
    
  }
  
  func resolveShowPictures(for intent: SelectCharacterIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
    
    
  }
  
  override func handler(for intent: INIntent) -> Any {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self
  }
  
}
