//
//  ChangeNameCoordinator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ChangeNameCoordinator {
  
  func showChangeNameScreen(sourceVC: UIViewController) {
    let view = InitView()
    let vc = ChangeNameVC(screenView: view)
    sourceVC.showScreen(vc, animation: .push)
  }
}
