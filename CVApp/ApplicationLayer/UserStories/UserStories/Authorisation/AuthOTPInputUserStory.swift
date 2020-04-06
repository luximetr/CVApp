//
//  AuthOTPInputUserStory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthOTPInputUserStory {
    
    let presentation: AuthOTPInputPresentationProtocol
    
    init(presentation: AuthOTPInputPresentationProtocol) {
        self.presentation = presentation
    }
    
    func start(phoneNumber: String) {
        presentation.showAuthOTPInputScreen(phoneNumber: phoneNumber)
    }
}
