//
//  ServicesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ServicesFactory {
    
    let presentation: Presentation
    let screensFactory: ScreensFactory
    
    init(presentation: Presentation,
        screensFactory: ScreensFactory) {
        self.presentation = presentation
        self.screensFactory = screensFactory
    }
    
    func createSettingsService() -> SettingsService {
        return SettingsService(
            presentation: presentation,
            settingsScreen: screensFactory.createSettingsScreen())
    }
}
