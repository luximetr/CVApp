//
//  AppearancesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 17/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class AppearancesFactory {
  
  func createAppearance(theme: Theme) -> Appearance {
    switch theme.type {
    case .dark: return createDarkAppearance()
    case .light: return createLightAppearance()
    case .glamour: return createGlamourAppearance()
    }
  }
  
  private func createLightAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .white,
      secondaryBackgroundColor: .color(red: 235, green: 235, blue: 235),
      statusBarStyle: .dark,
      navigationBackgroundColor: .white,
      navigationTintColor: .black,
      navigationShadowColor: .color(red: 170, green: 170, blue: 170),
      tabBarBackgroundColor: .white,
      tabBarSelectedTintColor: .blue,
      tabBarUnselectedTintColor: .lightGray,
      primaryTextColor: .black,
      secondaryTextColor: .lightGray,
      disruptiveTextColor: .red,
      primaryActionColor: .blue,
      primaryActionTitleColor: .white,
      iconTintColor: .black,
      dividerBackgroundColor: .lightGray
    )
  }
  
  func createDarkAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .black,
      secondaryBackgroundColor: .gray,
      statusBarStyle: .light,
      navigationBackgroundColor: .black,
      navigationTintColor: .white,
      navigationShadowColor: .color(red: 25, green: 25, blue: 25),
      tabBarBackgroundColor: .black,
      tabBarSelectedTintColor: .white,
      tabBarUnselectedTintColor: .lightGray,
      primaryTextColor: .white,
      secondaryTextColor: .color(red: 235, green: 235, blue: 235),
      disruptiveTextColor: .red,
      primaryActionColor: .cyan,
      primaryActionTitleColor: .black,
      iconTintColor: .white,
      dividerBackgroundColor: .white
    )
  }
  
  func createGlamourAppearance() -> Appearance {
    return Appearance(
      primaryBackgroundColor: .color(red: 174, green: 47, blue: 117),
      secondaryBackgroundColor: .color(red: 177, green: 88, blue: 139),
      statusBarStyle: .light,
      navigationBackgroundColor: .color(red: 164, green: 37, blue: 107),
      navigationTintColor: .color(red: 247, green: 209, blue: 229),
      navigationShadowColor: .color(red: 144, green: 17, blue: 87),
      tabBarBackgroundColor: .color(red: 164, green: 37, blue: 107),
      tabBarSelectedTintColor: .white,
      tabBarUnselectedTintColor: .color(red: 204, green: 204, blue: 204),
      primaryTextColor: .white,
      secondaryTextColor: .color(red: 204, green: 204, blue: 204),
      disruptiveTextColor: .color(red: 255, green: 85, blue: 85),
      primaryActionColor: .color(red: 153, green: 23, blue: 75),
      primaryActionTitleColor: .white,
      iconTintColor: .color(red: 247, green: 209, blue: 229),
      dividerBackgroundColor: .color(red: 204, green: 204, blue: 204)
    )
  }
}
