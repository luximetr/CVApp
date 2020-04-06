//
//  AuthOTPInputPresentation.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 5/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthOTPInputPresentationProtocol {
    func showAuthOTPInputScreen(phoneNumber: String)
}

protocol AuthOTPInputPresentationOutput: class {
    func otpWasSent(to phoneNumber: String)
}

class AuthOTPInputPresentation: AuthOTPInputPresentationProtocol, AuthOTPInputVCOutput {
    
    weak var navigationController: UINavigationController?
    weak var output: AuthOTPInputPresentationOutput?
    
    func showAuthOTPInputScreen(phoneNumber: String) {
        let vc = AuthOTPInputVC()
        vc.output = self
        vc.view.backgroundColor = .orange
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - AuthOTPInputVCOutput
    
    func didTapOnContinue() {
        output?.otpWasSent(to: "+380661112233")
    }
}
