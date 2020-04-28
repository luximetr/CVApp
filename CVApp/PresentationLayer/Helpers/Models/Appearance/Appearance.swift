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
  let text: Text
  let statusBar: StatusBar
  let navigation: Navigation
  let tabBar: TabBar
  let action: ActionType
  
  let iconTintColor: UIColor
  
  let dividerBackgroundColor: UIColor
  


  struct Background {
    let primary: UIColor
    let secondary: UIColor
  }
  
  struct Text {
    let primary: UIColor
    let secondary: UIColor
    let disruptive: UIColor
    let positive: UIColor
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
  
  struct ActionType {
    let primary: Action
  }
  
  struct Action {
    let background: UIColor
    let title: UIColor
  }
}
