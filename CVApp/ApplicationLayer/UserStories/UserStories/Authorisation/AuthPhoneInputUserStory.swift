//
//  AuthPhoneInputUserStory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthPhoneInputUserStoryOutput: class {
    func otpWasSentTo(phoneNumber: String)
}

class AuthPhoneInputUserStory: AuthPhoneInputVCOutput {
    
    let presentation: AuthPhoneInputPresentation
    
    weak var output: AuthPhoneInputUserStoryOutput?
    
    init(presentation: AuthPhoneInputPresentation) {
        self.presentation = presentation
    }
    
    func showScreen() {
        presentation.showPhoneInputScreen()
    }
    
    // MARK: - AuthPhoneInputVCOutput
    
    func didTapOnContinue() {
        output?.otpWasSentTo(phoneNumber: "+380661112233")
    }
}
