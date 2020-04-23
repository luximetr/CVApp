//
//  SkillsListCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListCoordinator: SkillsListVCOutput {
  
  private let servicesFactory: ServicesFactory
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  weak var screen: SkillsListVC?
  
  func createSkillsListScreen() -> UIViewController {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view)
    vc.output = self
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.changeUserNameService = servicesFactory.createChangeUserNameService()
    vc.getCVService = servicesFactory.createGetCVService()
    vc.imageSetService = servicesFactory.createImageSetFromURLService()
    servicesFactory.createChangeUserAvatarService().addObserver(vc)
    screen = vc
    return vc
  }
  
  // MARK: - SkillsListVCOutput
  
  func didTapOnUserInfo(in vc: UIViewController, userInfo: UserInfo) {
    let coordinator = EditUserInfoCoordinator(servicesFactory: servicesFactory)
    coordinator.showEditUserInfoScreen(sourceVC: vc, userInfo: userInfo)
  }
  
}
