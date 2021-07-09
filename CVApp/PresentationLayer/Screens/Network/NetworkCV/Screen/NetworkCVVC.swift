//
//  NetworkCVVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol NetworkCVVCOutput: AnyObject {
  func didTapOnBack(in vc: UIViewController)
}

class NetworkCVVC: ScreenController, SkillsListViewDelegate {
  
  // MARK: - UI elements
  
  private let selfView: NetworkCVView
  
  // MARK: - Dependencies
  
  var output: NetworkCVVCOutput?
  var sendMailService: SendMailService!
  var callPhoneService: CallPhoneService!
  var openLinkService: OpenLinkExternallyService!
  
  // MARK: - Data
  
  private let cv: CV
  
  // MARK: - Life cycle
  
  init(view: NetworkCVView, cv: CV, currentApperanceService: AppearanceService) {
    selfView = view
    self.cv = cv
    super.init(screenView: view, currentAppearanceService: currentApperanceService)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    selfView.displayCV(cv)
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    selfView.navigationBarView.leftButton.addAction(self, action: #selector(didTapOnBack))
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "network_cv.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBack() {
    output?.didTapOnBack(in: self)
  }
  
  // SkillsListViewDelegate
  
  func didTapOnUserInfo() {
  }
  
  func didTapOnEmail(_ email: String) {
    sendMailService.sendMail(to: email)
  }
  
  func didTapOnPhone(_ phone: String) {
    callPhoneService.callPhoneNumber(phone)
  }
  
  func didTapOnMessanger(_ messanger: MessangerContact) {
    openLinkService.openURL(messanger.link)
  }
}
