//
//  PresentationsFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 5/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class PresentationsFactory {
    
    func createAuthOTPInputPresentation() -> AuthOTPInputPresentationProtocol {
        return AuthOTPInputPresentation()
    }
}
