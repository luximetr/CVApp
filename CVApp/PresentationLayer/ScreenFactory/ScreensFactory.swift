//
//  ScreensFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ScreensFactory {
    
    func createSettingsScreen() -> SettingsVC {
        let vc = SettingsVC()
        vc.view.backgroundColor = .blue
        return vc
    }
    
    func createAuthPhoneInputScreen() -> AuthPhoneInputVC {
        let vc = AuthPhoneInputVC()
        vc.view.backgroundColor = .red
        return vc
    }
    
    func createAuthOTPInputScreen() -> AuthOTPInputVC {
        let vc = AuthOTPInputVC()
        vc.view.backgroundColor = .orange
        return vc
    }
}
