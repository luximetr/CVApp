//
//  AuthorisationUserStory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthorisationUserStory: AuthPhoneInputUserStoryOutput {
    
    private let presentation: AuthorisationPresentation
    private let phoneInputStory: AuthPhoneInputUserStory
    private let otpInputStory: AuthOTPInputUserStory
    
    init(presentation: AuthorisationPresentation,
         phoneInputStory: AuthPhoneInputUserStory,
         otpInputStory: AuthOTPInputUserStory) {
        self.presentation = presentation
        self.phoneInputStory = phoneInputStory
        self.otpInputStory = otpInputStory
        phoneInputStory.output = self
    }
    
    func start() {
        
        phoneInputStory.showScreen()
    }
    
    // MARK: - AuthPhoneInputUserStoryOutput
    
    func otpWasSentTo(phoneNumber: String) {
//        otpInputStory.start(sourceVC: sourceVC, phoneNumber: phoneNumber)
    }
}
