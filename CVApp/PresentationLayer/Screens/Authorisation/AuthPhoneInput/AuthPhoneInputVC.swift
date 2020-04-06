//
//  AuthPhoneInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthPhoneInputVCOutput: class {
    func didTapOnContinue()
}

class AuthPhoneInputVC: ScreenController {
    
    let continueButton = UIButton()
    weak var output: AuthPhoneInputVCOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        continueButton.addTarget(self, action: #selector(didTapOnContinue), for: .touchUpInside)
        continueButton.backgroundColor = .black
    }
    
    @objc
    private func didTapOnContinue() {
        output?.didTapOnContinue()
    }
}
