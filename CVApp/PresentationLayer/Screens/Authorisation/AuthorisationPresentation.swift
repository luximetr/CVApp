//
//  AuthorisationPresentation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 5/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthorisationPresentation {
    
    weak var window: UIWindow? {
        didSet {
            let navigationController = SwipeNavigationController()
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            self.navigationController = navigationController
        }
    }
    weak var navigationController: UINavigationController? {
        didSet {
            self.inputPhonePresentation.navigationController = navigationController
            self.inputOTPPresentation.navigationController = navigationController
        }
    }
    
    let inputPhonePresentation = AuthPhoneInputPresentation()
    let inputOTPPresentation = AuthOTPInputPresentation()
    
    func start() {
        let navigationController = SwipeNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.navigationController = navigationController
    }
}
