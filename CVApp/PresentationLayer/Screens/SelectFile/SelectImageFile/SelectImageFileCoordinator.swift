//
//  SelectImageFileCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 22/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SelectImageFileCoordinator {
  
  func showGalleryPicker(sourceVC: UIViewController, completion: @escaping GalleryMediaPickerCoordinator.Completion) {
    let coordinator = GalleryMediaPickerCoordinator()
    coordinator.showGalleryMediaPicker(sourceVC: sourceVC, completion: completion)
  }
  
  func showCameraPicker(sourceVC: UIViewController) {
    
  }
}
