//
//  Appearance.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 16/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

struct Appearance {
  
  let background: Background
  let statusBar: StatusBar
  let navigation: Navigation
  let tabBar: TabBar
  
  let primaryTextColor: UIColor
  let secondaryTextColor: UIColor
  let disruptiveTextColor: UIColor
  let positiveTextColor: UIColor
  
  let primaryActionColor: UIColor
  let primaryActionTitleColor: UIColor
  
  let iconTintColor: UIColor
  
  let dividerBackgroundColor: UIColor
  


  struct Background {
    let primary: UIColor
    let secondary: UIColor
  }
  
  struct StatusBar {
    let style: StatusBarStyle
  }
  
  struct Navigation {
    let background: UIColor
    let tint: UIColor
    let shadow: UIColor
  }
  
  struct TabBar {
    let background: UIColor
    let selectedTint: UIColor
    let unselectedTint: UIColor
  }
}
