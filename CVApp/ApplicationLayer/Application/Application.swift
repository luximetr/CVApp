//
//  Application.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class Application: UIApplication, UIApplicationDelegate {
    
    // MARK: - Layers
    
    private lazy var presentation: Presentation = {
        return Presentation()
    }()
    
    // MARK: - Factories
    
    private lazy var servicesFactory: ServicesFactory = {
        return ServicesFactory(
            presentation: self.presentation,
            screensFactory: self.screensFactory)
    }()
    private lazy var screensFactory = ScreensFactory()
    private lazy var userStoriesFactory = {
        return UserStoriesFactory(
            servicesFactory: self.servicesFactory,
            screensFactory: self.screensFactory,
            presentation: self.presentation,
            presentationsFactory: self.presentationsFactory)
    }()
    private lazy var presentationsFactory: PresentationsFactory = {
       return PresentationsFactory()
    }()
    
    private var startUserStory: Any?
    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let startUserStory = userStoriesFactory.createStartUserStory()
        startUserStory.start()
        self.startUserStory = startUserStory
        
        return true
    }
}
