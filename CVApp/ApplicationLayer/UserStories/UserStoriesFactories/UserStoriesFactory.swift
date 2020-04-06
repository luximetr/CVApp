//
//  UserStoriesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class UserStoriesFactory {
    
    let servicesFactory: ServicesFactory
    let screensFactory: ScreensFactory
    let presentation: Presentation
    let presentationsFactory: PresentationsFactory
    
    init(servicesFactory: ServicesFactory,
         screensFactory: ScreensFactory,
         presentation: Presentation,
         presentationsFactory: PresentationsFactory) {
        self.servicesFactory = servicesFactory
        self.screensFactory = screensFactory
        self.presentation = presentation
        self.presentationsFactory = presentationsFactory
    }
    
    func createStartUserStory() -> StartUserStory {
        return StartUserStory(
            authorisationStory: createAuthorisationStory())
    }
    
    func createAuthorisationStory() -> AuthorisationUserStory {
        return AuthorisationUserStory(
            presentation: presentation.auth,
            phoneInputStory: createPhoneInputStory(),
            otpInputStory: createOTPInputStory())
    }
    
    func createPhoneInputStory() -> AuthPhoneInputUserStory {
        return AuthPhoneInputUserStory(
            presentation: presentation.auth.inputPhonePresentation)
    }
    
    func createOTPInputStory() -> AuthOTPInputUserStory {
        return AuthOTPInputUserStory(
            presentation: presentation.auth.inputOTPPresentation)
    }
}
