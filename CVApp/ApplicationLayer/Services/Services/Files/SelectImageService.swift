//
//  SelectImageService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SelectImageService {
  
  // MARK: - Dependencies
  
  private let stringsLocalizeService: StringsLocalizeService
  private let checkFileSizeService: CheckFileSizeService
  
  // MARK: - Data
  
  private weak var sourceVC: SourceVCType?
  private var completion: Completion?
  private let maxFileSizeInMB: Double = 10
  
  // MARK: - Life cycle
  
  init(stringsLocalizeService: StringsLocalizeService,
       checkFileSizeService: CheckFileSizeService) {
    self.stringsLocalizeService = stringsLocalizeService
    self.checkFileSizeService = checkFileSizeService
  }
  
  // MARK: - Select image
  
  func selectImage(sourceVC: SourceVCType, completion: @escaping Completion) {
    self.sourceVC = sourceVC
    self.completion = completion
    showSelectSourceAlert()
  }
  
  // MARK: - Select source - Show alert
  
  private func showSelectSourceAlert() {
    let viewModel = createSelectSourceAlertViewModel()
    sourceVC?.showSheetAlert(viewModel: viewModel)
  }
  
  private func createSelectSourceAlertViewModel() -> AlertViewModel {
    return AlertViewModel(
      title: getLocalizedString(key: "select_image_file_options.title"),
      message: nil,
      actions: [
        createGallerySourceAlertAction(),
        createCameraSourceAlertAction(),
        createSelectSourceCancelAction()
      ]
    )
  }
  
  private func createGallerySourceAlertAction() -> AlertAction {
    return AlertAction(
      title: getLocalizedString(key: "select_image_file_options.gallery"),
      action: { [weak self] in self?.didTapOnSelectFromGallery() },
      style: .normal)
  }
  
  private func createCameraSourceAlertAction() -> AlertAction {
    return AlertAction(
      title: getLocalizedString(key: "select_image_file_options.camera"),
      action: { [weak self] in self?.didTapOnSelectFromCamera() },
      style: .normal)
  }
  
  private func createSelectSourceCancelAction() -> AlertAction {
    return AlertAction(
      title: getLocalizedString(key: "select_image_file_options.cancel"),
      action: {},
      style: .highlighted)
  }
  
  // MARK: - Select source - Actions
  
  private func didTapOnSelectFromGallery() {
    guard let sourceVC = sourceVC else { return }
    let coordinator = GalleryMediaPickerCoordinator()
    coordinator.showGalleryMediaPicker(sourceVC: sourceVC, completion: { [weak self] file in
      self?.fileSelected(.local(file))
    })
  }
  
  private func didTapOnSelectFromCamera() {
    guard let sourceVC = sourceVC else { return }
    let coordinator = CameraMediaPickerCoordinator()
    coordinator.showCameraMediaPicker(sourceVC: sourceVC, completion: { [weak self] file in
      self?.fileSelected(.temp(file))
    })
  }
  
  // MARK: - File selected
  
  private func fileSelected(_ file: ImageFile) {
    let result = checkFileSizeService.checkFileSize(file, maxMBs: maxFileSizeInMB)
    switch result {
    case .success:
      completion?(file)
    case .failure(let error):
      sourceVC?.showRepeatErrorAlert(message: error.message, onRepeat: { [weak self] in
        self?.showSelectSourceAlert()
      })
    }
  }
  
  // MARK: - Localized string
  
  private func getLocalizedString(key: String) -> String {
    return stringsLocalizeService.getLocalizedString(key: key)
  }
  
  // MARK: - Typealiases
  
  typealias SourceVCType = (UIViewController & ErrorAlertDisplayable & SheetAlertDisplayable)
  typealias Completion = (ImageFile) -> Void
}
