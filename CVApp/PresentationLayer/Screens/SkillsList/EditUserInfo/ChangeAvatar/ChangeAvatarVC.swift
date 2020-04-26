//
//  ChangeAvatarVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol ChangeAvatarVCOutput: class {
  func didTapOnBack(in vc: UIViewController)
  func didTapOnPickAvatarFromGallery(in vc: UIViewController, completion: @escaping GalleryMediaPickerCoordinator.Completion)
  func didTapOnPickAvatarFromCamera(in vc: UIViewController)
  func avatarChangingFinished(in vc: UIViewController)
}

class ChangeAvatarVC: ScreenController, OverScreenLoaderDisplayable, ErrorAlertDisplayable, SheetAlertDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: ChangeAvatarView
  
  // MARK: - Dependencies
  
  var output: ChangeAvatarVCOutput?
  var changeAvatarService: ChangeUserAvatarService!
  var imageSetService: ImageSetFromURLService!
  
  // MARK: - Data
  
  private var avatarURL: URL?
  private var selectedLocalFile: LocalFile?
  
  // MARK: - Life cycle
  
  init(view: ChangeAvatarView, avatarURL: URL?) {
    selfView = view
    self.avatarURL = avatarURL
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    displayAvatar(imageURL: avatarURL)
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    setupViewActions()
  }
  
  private func setupViewActions() {
    selfView.navigationBarView.leftButton.actionButton.addAction(self, action: #selector(didTapOnBackButton))
    selfView.changeAvatarButton.addAction(self, action: #selector(didTapOnChangeAvatarButton))
    selfView.continueButton.addAction(self, action: #selector(didTapOnContinueButton))
  }
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "change_avatar.title")
    selfView.changeAvatarButton.title = getLocalizedString(key: "change_avatar.change.title")
    selfView.continueButton.title = getLocalizedString(key: "change_avatar.continue.title")
  }
  
  // MARK: - View - Actions
  
  @objc
  private func didTapOnBackButton() {
    output?.didTapOnBack(in: self)
  }
  
  @objc
  private func didTapOnChangeAvatarButton() {
    selectAvatar()
  }
  
  @objc
  private func didTapOnContinueButton() {
    guard let file = selectedLocalFile else { return }
    changeAvatar(file: file)
  }
  
  // MARK: - Avatar - Select
  
  private func selectAvatar() {
    showAvatarSelectionOptions()
  }
  
  // MARK: - Avatar - Selection options
  
  private func showAvatarSelectionOptions() {
    let galleryAction = AlertAction(
      title: getLocalizedString(key: "change_avatar.selection_options.gallery"),
      action: { [weak self] in self?.selectAvatarFromGallery() },
      style: .normal)
    let cameraAction = AlertAction(
      title: getLocalizedString(key: "change_avatar.selection_options.camera"),
      action: { [weak self] in self?.selectAvatarFromCamera() },
      style: .normal)
    let cancelAction = AlertAction(
      title: getLocalizedString(key: "change_avatar.selection_options.cancel"),
      action: {},
      style: .highlighted)
    let actions = [galleryAction, cameraAction, cancelAction]
    let alertViewModel = AlertViewModel(
      title: getLocalizedString(key: "change_avatar.selection_options.title"),
      message: getLocalizedString(key: "change_avatar.selection_options.message"),
      actions: actions)
    showSheetAlert(viewModel: alertViewModel)
  }
  
  // MARK: - Avatar select from gallery
  
  private func selectAvatarFromGallery() {
    output?.didTapOnPickAvatarFromGallery(in: self, completion: { [weak self] result in
      switch result {
      case .success(let file):
        self?.selectedLocalFile = file
        self?.displayAvatar(imageURL: file.localURL)
      case .failure:
        break
      }
    })
  }
  
  // MARK: - Avatar select from camera
  
  private func selectAvatarFromCamera() {
    
  }
  
  // MARK: - Avatar - Change
  
  private func changeAvatar(file: LocalFile) {
    showOverScreenLoader()
    changeAvatarService.changeAvatar(file, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      self?.hideOverScreenLoader()
      switch result {
      case .success:
        strongSelf.output?.avatarChangingFinished(in: strongSelf)
      case .failure(let error):
        strongSelf.showErrorAlert(message: error.message, onRepeat: {
          self?.changeAvatar(file: file)
        })
      }
    })
  }
  
  // MARK: - Avatar - Display
  
  private func displayAvatar(imageURL: URL?) {
    imageSetService.setImage(imageView: selfView.avatarView.imageView, imageURL: imageURL)
  }
}
