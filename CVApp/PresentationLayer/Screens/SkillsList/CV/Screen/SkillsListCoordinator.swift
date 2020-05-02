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
    let vc = SkillsListVC(
      view: view,
      currentAppearanceService: servicesFactory.createAppearanceService())
    view.delegate = vc
    view.currentAppearanceService = servicesFactory.createAppearanceService()
    view.imageSetService = servicesFactory.createImageSetFromURLService()
    vc.output = self
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "SkillsList")
    vc.changeCVUserNameService = servicesFactory.createChangeCVUserNameService()
    vc.getCVService = servicesFactory.createGetCVService()
    vc.callPhoneService = servicesFactory.createCallPhoneService()
    vc.openLinkService = servicesFactory.createOpenLinkExternallyService()
    vc.sendMailService = servicesFactory.createSendMailService()
    vc.showErrorAlertService = servicesFactory.createShowErrorAlertService()
    servicesFactory.createChangeCVAvatarService().addObserver(vc)
    servicesFactory.createChangeUserRoleService().addObserver(vc)
    screen = vc
    return vc
  }
  
  // MARK: - SkillsListVCOutput
  
  func didTapOnUserInfo(in vc: UIViewController, cvId: CVIdType, userInfo: UserInfo) {
    let coordinator = EditUserInfoCoordinator(servicesFactory: servicesFactory)
    coordinator.showEditUserInfoScreen(sourceVC: vc, cvId: cvId, userInfo: userInfo)
  }
  
}
