//
//  StartUserStory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class StartUserStory {
    
    let authorisationStory: AuthorisationUserStory
    
    init(authorisationStory: AuthorisationUserStory) {
        self.authorisationStory = authorisationStory
    }
    
    func start() {
        authorisationStory.start()
    }
}
