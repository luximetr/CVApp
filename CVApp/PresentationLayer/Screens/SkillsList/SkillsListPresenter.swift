//
//  SkillsListPresenter.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListPresenter: SkillsListVCOutput {
  
  var screen: (UIViewController & SkillsListVCInput)!
  var output: SkillsListPresenterOutput!
}

protocol SkillsListPresenterOutput {
  
}
