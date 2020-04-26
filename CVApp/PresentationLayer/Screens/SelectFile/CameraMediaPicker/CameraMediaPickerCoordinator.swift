//
//  CameraMediaPickerCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class CameraMediaPickerCoordinator: CameraMediaPickerControllerOutput {
  
  // MARK: - Data
  
  private var completionBlock: Completion?
  
  // MARK: - Create screen
  
  private func createCameraMediaPickerController() -> UIViewController {
    let vc = CameraMediaPickerController()
    vc.delegate = vc
    vc.sourceType = .camera
    vc.output = self
    vc.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
    return vc
  }
  
  // MARK: - Routing
  
  func showCameraMediaPicker(sourceVC: UIViewController, completion: @escaping Completion) {
    completionBlock = completion
    let vc = createCameraMediaPickerController()
    sourceVC.showScreen(vc, animation: .present)
  }
  
  // MARK: - CameraMediaPickerControllerOutput
  
  func didSelectFile(_ file: TempImageFile, in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
    completionBlock?(file)
  }
  
  func didTapOnCancel(in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
  }
  
  func selectionFailed(in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (TempImageFile) -> Void
}
