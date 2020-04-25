//
//  GalleryMediaPickerCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class GalleryMediaPickerCoordinator: GalleryMediaPickerControllerOutput {
  
  private var completionBlock: Completion?
  
  // MARK: - Create screen
  
  private func createGalleryMediaPickerController() -> UIViewController {
    let vc = GalleryMediaPickerController()
    vc.delegate = vc
    vc.sourceType = .photoLibrary
    vc.output = self
    return vc
  }
  
  // MARK: - Routing
  
  func showGalleryMediaPicker(sourceVC: UIViewController, completion: @escaping Completion) {
    completionBlock = completion
    let vc = createGalleryMediaPickerController()
    sourceVC.showScreen(vc, animation: .present)
  }
  
  // MARK: - GalleryMediaPickerControllerOutput
  
  func didSelect(file: LocalFile, in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
    completionBlock?(.success(file))
  }
  
  func selectionFailed(in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
  }
  
  func didTapOnCancel(in vc: UIViewController) {
    vc.closeScreen(animation: .dismiss)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (Result<LocalFile, Error>) -> Void
}

