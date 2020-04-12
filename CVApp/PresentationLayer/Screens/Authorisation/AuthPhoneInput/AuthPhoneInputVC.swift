//
//  AuthPhoneInputVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol AuthPhoneInputVCOutput {
  
}

class AuthPhoneInputVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: AuthPhoneInputView
  
  // MARK: - Dependencies
  
  var output: AuthPhoneInputVCOutput!
  var requestOTPService: RequestOTPService!
  
  // MARK: - Life cycle
  
  init(view: AuthPhoneInputView) {
    selfView = view
    super.init()
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    displayTextValues()
  }
  
  // MARK: - View - Text values
  
  private func displayTextValues() {
    navigationItem.title = "Auth"
    selfView.continueButton.setTitle("Continue", for: .normal)
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnContinue() {
    
  }
}
