//
//  InitView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SnapKit

class InitView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
    }
    
    func autoLayout() {
        
    }
}
