//
//  AuthPhoneInputPresentation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 5/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class AuthPhoneInputPresentation {
    
    weak var window: UIWindow?
    weak var navigationController: UINavigationController?
    
    func showPhoneInputScreen() {
        let vc = AuthPhoneInputVC()
        vc.view.backgroundColor = .red
        navigationController?.viewControllers = [vc]
    }
}
