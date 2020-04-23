//
//  EditUserInfoCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 23/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class EditUserInfoCoordinator: EditUserInfoVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  private func createEditUserInfoScreen(userInfo: UserInfo) -> UIViewController {
    let view = EditUserInfoView()
    let vc = EditUserInfoVC(view: view, userInfo: userInfo)
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.imageSetService = servicesFactory.createImageSetFromURLService()
    servicesFactory.createChangeUserAvatarService().addObserver(vc)
    servicesFactory.createChangeUserNameService().addObserver(vc)
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showEditUserInfoScreen(sourceVC: UIViewController, userInfo: UserInfo) {
    let vc = createEditUserInfoScreen(userInfo: userInfo)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // EditUserInfoVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
  
  func didTapOnEditAvatar(in vc: UIViewController, avatarURL: URL?) {
    let coordinator = ChangeAvatarCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeAvatarScreen(sourceVC: vc, avatarURL: avatarURL)
  }
  
  func didTapOnEditName(in vc: UIViewController, name: String) {
    let coordinator = ChangeNameCoordinator(servicesFactory: servicesFactory)
    coordinator.showChangeNameScreen(sourceVC: vc, name: name)
  }
  
  func didTapOnEditRole(in vc: UIViewController, role: String) {
    
  }
}
