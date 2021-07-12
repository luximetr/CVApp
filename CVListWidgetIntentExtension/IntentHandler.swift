//
//  IntentHandler.swift
//  CVListWidgetIntentExtension
//
//  Created by Oleksandr Orlov on 09.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Intents

class IntentHandler: INExtension, SelectCharacterIntentHandling {
  
  func resolveCharacter(for intent: SelectCharacterIntent, with completion: @escaping (GameCharacterResolutionResult) -> Void) {
    
  }
  
  func provideCharacterOptionsCollection(for intent: SelectCharacterIntent, with completion: @escaping (INObjectCollection<GameCharacter>?, Error?) -> Void) {
    
    let characters: [GameCharacter] = CharacterDetail.availableCharacters.map { character in
                let gameCharacter = GameCharacter(
                    identifier: character.name,
                    display: character.name
                )
                gameCharacter.name = character.name
                return gameCharacter
            }
    
    let collection = INObjectCollection(items: characters)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
      completion(collection, nil)
    })
  }
  
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
