//
//  SkillsListVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListVCOutput {
  func didTapOnUserInfo(in vc: UIViewController, cvId: CVIdType, userInfo: UserInfo)
}

class SkillsListVC: ScreenController, CurrentUserNameChangedObserver, CVAvatarChangedObserver, CurrentUserRoleChangedObserver, ErrorAlertDisplayable, SkillsListViewDelegate {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
    
  // MARK: - Dependencies
  
  var output: SkillsListVCOutput!
  var changeUserNameService: ChangeUserNameService!
  var getCVService: GetCVService!
  var callPhoneService: CallPhoneService!
  var openLinkService: OpenLinkExternallyService!
  var sendMailService: SendMailService!
  
  // MARK: - Data
  
  private var cv: CV?
  
  // MARK: - Life cycle
  
  init(view: SkillsListView) {
    selfView = view
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservers()
    displayCV()
  }
  
  // MARK: - View - Setup
  
  private func setupObservers() {
    changeUserNameService.addObserver(self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "skills_list.title")
  }
  
  // MARK: - CV - Display
  
  private func displayCV() {
    displayCachedCV()
    loadCV()
  }
  
  private func displayCachedCV() {
    guard let cachedCV = getCVService.getCachedCV() else { return }
    cv = cachedCV
    displayCV(cachedCV)
  }
  
  private func loadCV() {
    getCVService.getCV(completion: { [weak self] result in
      switch result {
      case .success(let cv):
        self?.displayCV(cv)
      case .failure(let error):
        self?.showRepeatErrorAlert(message: error.message, onRepeat: {
          self?.loadCV()
        })
      }
    })
  }
  
  private func displayCV(_ cv: CV) {
    self.cv = cv
    selfView.displayCV(cv)
  }
  
  // MARK: - User info - Avatar - Changed
  // CurrentUserAvatarChangedObserver
  
  func cvAvatarChanged(_ avatarURL: URL) {
    cv?.userInfo.avatarURL = avatarURL
    selfView.displayUserAvatar(avatarURL)
  }
   
  // MARK: - User info - Name - Changed
  // CurrentUserNameChangedObserver
   
  func currentUserNameChanged(_ name: String) {
    cv?.userInfo.name = name
    selfView.displayUserName(name)
  }
  
  // MARK: - User info - Role - Changed
  
  func currentUserRoleChanged(_ role: String) {
    cv?.userInfo.role = role
    selfView.displayUserRole(role)
  }
  
  // MARK: - User info - Actions
  
  func didTapOnUserInfo() {
    guard let userInfo = cv?.userInfo, let cvId = cv?.id else { return }
    output.didTapOnUserInfo(in: self, cvId: cvId, userInfo: userInfo)
  }
  
  // MARK: - Phones - Actions
  
  func didTapOnPhone(_ phone: String) {
    callPhoneService.callPhoneNumber(phone)
  }
  
  // MARK: - Emails - Actions
  
  func didTapOnEmail(_ email: String) {
    sendMailService.sendMail(to: email)
  }
  
  // MARK: - Messangers - Actions
  
  func didTapOnMessanger(_ messanger: MessangerContact) {
    openLinkService.openURL(messanger.link)
  }
  
}
