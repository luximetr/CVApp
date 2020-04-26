//
//  ChangeAvatarCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeAvatarCoordinator: ChangeAvatarVCOutput {
  
  // MARK: - Dependencies
  
  private let servicesFactory: ServicesFactory
  
  // MARK: - Life cycle
  
  init(servicesFactory: ServicesFactory) {
    self.servicesFactory = servicesFactory
  }
  
  // MARK: - Create screen
  
  func createChangeAvatarScreen(avatarURL: URL?) -> UIViewController {
    let view = ChangeAvatarView()
    let vc = ChangeAvatarVC(view: view, avatarURL: avatarURL)
    vc.currentLanguageService = servicesFactory.createLanguagesService()
    vc.currentAppearanceService = servicesFactory.createAppearanceService()
    vc.stringsLocalizeService = servicesFactory.createStringsLocalizeService()
    vc.changeAvatarService = servicesFactory.createChangeUserAvatarService()
    vc.imageSetService = servicesFactory.createImageSetFromURLService()
    vc.output = self
    vc.hidesBottomBarWhenPushed = true
    return vc
  }
  
  func showChangeAvatarScreen(sourceVC: UIViewController, avatarURL: URL?) {
    let vc = createChangeAvatarScreen(avatarURL: avatarURL)
    sourceVC.showScreen(vc, animation: .push)
  }
  
  // MARK: - ChangeAvatarVCOutput
  
  func didTapOnBack(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
  
  func didTapOnPickAvatarFromCamera(in vc: UIViewController, completion: @escaping CameraMediaPickerCoordinator.Completion) {
    let coordinator = SelectImageFileCoordinator()
    coordinator.showCameraPicker(sourceVC: vc, completion: completion)
  }
  
  func didTapOnPickAvatarFromGallery(in vc: UIViewController, completion: @escaping GalleryMediaPickerCoordinator.Completion) {
    let coordinator = SelectImageFileCoordinator()
    coordinator.showGalleryPicker(sourceVC: vc, completion: completion)
  }
  
  func avatarChangingFinished(in vc: UIViewController) {
    vc.closeScreen(animation: .pop)
  }
}
