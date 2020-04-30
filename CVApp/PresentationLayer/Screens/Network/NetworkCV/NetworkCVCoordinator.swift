//
//  NetworkCVCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 30/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkCVCoordinator: NetworkCVVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  private func createNetworkCVScreen(cv: CV) -> UIViewController {
    let view = NetworkCVView()
    let vc = NetworkCVVC(view: view, cv: cv)
    view.delegate = vc
    view.currentAppearanceService = servicesFactory.createAppearanceService()
    view.imageSetService = servicesFactory.createImageSetFromURLService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.callPhoneService = servicesFactory.createCallPhoneService()
    vc.openLinkService = servicesFactory.createOpenLinkExternallyService()
    vc.sendMailService = servicesFactory.createSendMailService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  // MARK: - Routing
  
  func showShowNetworkCVScreen(sourceVC: UIViewController, cv: CV) {
    let vc = createNetworkCVScreen(cv: cv)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - NetworkCVVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
