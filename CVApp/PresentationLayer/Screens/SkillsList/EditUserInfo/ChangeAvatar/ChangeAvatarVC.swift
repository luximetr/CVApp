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
  func avatarChangingFinished(in vc: UIViewController)
}

class ChangeAvatarVC: ScreenController, OverScreenLoaderDisplayable, ErrorAlertDisplayable, SheetAlertDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: ChangeAvatarView
  
  // MARK: - Dependencies
  
  var output: ChangeAvatarVCOutput?
  var changeAvatarService: ChangeCVAvatarService!
  var imageSetService: ImageSetFromURLService!
  var selectImageService: SelectImageService!
  
  // MARK: - Data
  
  private let cvId: CVIdType
  private var avatarURL: URL?
  private var selectedImage: ImageFile?
  
  // MARK: - Life cycle
  
  init(view: ChangeAvatarView, cvId: CVIdType, avatarURL: URL?) {
    selfView = view
    self.cvId = cvId
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
    guard let file = selectedImage else { return }
    changeAvatar(file: file)
  }
  
  // MARK: - Avatar - Select
  
  private func selectAvatar() {
    selectImageService.selectImage(sourceVC: self, completion: { [weak self] file in
      self?.selectedImage = file
      self?.displayAvatar(imageFile: file)
    })
  }
  
  // MARK: - Avatar - Change
  
  private func changeAvatar(file: ImageFile) {
    showOverScreenLoader()
    changeAvatarService.changeAvatar(cvId: cvId, file: file, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      self?.hideOverScreenLoader()
      switch result {
      case .success:
        strongSelf.output?.avatarChangingFinished(in: strongSelf)
      case .failure(let error):
        strongSelf.showRepeatErrorAlert(message: error.message, onRepeat: {
          self?.changeAvatar(file: file)
        })
      }
    })
  }
  
  // MARK: - Avatar - Display
  
  private func displayAvatar(imageFile: ImageFile) {
    switch imageFile {
    case .local(let file):
      displayAvatar(imageURL: file.localURL)
    case .temp(let file):
      displayAvatar(image: file.value)
    }
  }
  
  private func displayAvatar(imageURL: URL?) {
    imageSetService.setImage(imageView: selfView.avatarView.imageView, imageURL: imageURL)
  }
  
  private func displayAvatar(image: UIImage) {
    selfView.avatarView.imageView.image = image
  }
}
