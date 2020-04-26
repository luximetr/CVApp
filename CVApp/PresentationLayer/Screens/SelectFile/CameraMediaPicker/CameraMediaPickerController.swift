//
//  CameraMediaPickerController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol CameraMediaPickerControllerOutput {
  func didSelectFile(_ file: TempImageFile, in vc: UIViewController)
  func selectionFailed(in vc: UIViewController)
  func didTapOnCancel(in vc: UIViewController)
}

class CameraMediaPickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - Dependencies
  
  var output: CameraMediaPickerControllerOutput?
  private let fileConvertor = TempImageFileConvertore()
  
  // MARK: - UIImagePickerControllerDelegate
  
  func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let file = fileConvertor.toFile(info: info) {
      output?.didSelectFile(file, in: self)
    } else {
      output?.selectionFailed(in: self)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    output?.didTapOnCancel(in: self)
  }
  
}
