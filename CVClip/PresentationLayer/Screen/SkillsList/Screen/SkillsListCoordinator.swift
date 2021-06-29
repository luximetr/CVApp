//
//  SkillsListCoordinator.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListCoordinator {
  
  func showSkillsList(window: UIWindow, userId: String?) {
    let viewController = createSkillsListVC(userId: userId)
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  private func createSkillsListVC(userId: String?) -> UIViewController {
    let view = SkillsListView()
    let vc = SkillsListVC(view: view, userId: userId)
    return vc
  }
  
}
