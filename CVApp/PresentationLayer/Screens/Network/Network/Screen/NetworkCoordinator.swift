//
//  NetworkCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkCoordinator: NetworkCVOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  func createNetworkScreen() -> UIViewController {
    let view = NetworkView()
    let vc = NetworkVC(view: view)
    view.delegate = vc
    view.imageSetService = servicesFactory.createImageSetFromURLService()
    view.appearanceService = servicesFactory.createAppearanceService()
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService(tableName: "Network")
    vc.getNetworkCVsService = servicesFactory.createGetNetworkCVsService()
    vc.output = self
    return vc
  }
  
  // MARK: -  NetworkCVOutput
  
  func didTapOnCV(_ cv: CV, in vc: UIViewController) {
    let coordinator = NetworkCVCoordinator(servicesFactory: servicesFactory)
    coordinator.showShowNetworkCVScreen(sourceVC: vc, cv: cv)
  }
  
}
