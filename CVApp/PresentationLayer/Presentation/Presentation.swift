//
//  Presentation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class Presentation {
    
    private let window: UIWindow
    
    let auth = AuthorisationPresentation()
    
    init() {
        self.window = UIWindow()
        auth.window = window
    }
}
