//
//  GalleryMediaPicker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol GalleryMediaPickerControllerOutput {
  func didSelect(file: LocalFile, in vc: UIViewController)
}

class GalleryMediaPickerController: UIImagePickerController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
  
  // MARK: - Dependencies
  
  var output: GalleryMediaPickerControllerOutput?
  private let fileConvertor = LocalFileConvertor()
  
  // MARK: - UIImagePickerControllerDelegate
  
  func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let file = fileConvertor.toFile(info: info) {
      output?.didSelect(file: file, in: self)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
  }
  
}
