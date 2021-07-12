//
//  CharacterDetails.swift
//  CVListWidgetIntentExtension
//
//  Created by Oleksandr Orlov on 09.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

struct CharacterDetail {
    let name: String
    let avatar: String
    let healthLevel: Double
    let heroType: String

    static let availableCharacters = [
        CharacterDetail(name: "Power Panda", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        CharacterDetail(name: "Unipony", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        CharacterDetail(name: "Spouty", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}
