//
//  SkillsListCoordinator.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListCoordinator {
  
  func showSkillsList(window: UIWindow) {
    let viewController = createSkillsListVC()
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  private func createSkillsListVC() -> UIViewController {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view)
    return vc
  }
  
}
