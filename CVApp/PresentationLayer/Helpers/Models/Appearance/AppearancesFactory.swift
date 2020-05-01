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
      background: .init(
        primary: .white,
        secondary: .color(red: 235, green: 235, blue: 235)),
      text: .init(
        primary: .black,
        secondary: .lightGray,
        disruptive: .red,
        positive: .color(red: 113, green: 181, blue: 130)),
      statusBar: .init(
        style: .dark),
      navigation: .init(
        background: .white,
        tint: .black,
        shadow: .color(red: 170, green: 170, blue: 170)),
      tabBar: .init(
        background: .white,
        selectedTint: .blue,
        unselectedTint: .lightGray,
        shadow: .color(red: 170, green: 170, blue: 170)),
      action: .init(
        primary: .init(
          background: .color(red: 93, green: 93, blue: 159),
          title: .white),
        secondary: .init(
          background: .clear,
          title: .color(red: 93, green: 93, blue: 159))),
      divider: .init(
        background: .color(red: 170, green: 170, blue: 170)),
      scrollIndicator: .init(
        style: .black),
      keyboard: .init(
        style: .light)
    )
  }
  
  func createDarkAppearance() -> Appearance {
    return Appearance(
      background: .init(
        primary: .black,
        secondary: .color(red: 45, green: 45, blue: 45)),
      text: .init(
        primary: .white,
        secondary: .color(red: 235, green: 235, blue: 235),
        disruptive: .red,
        positive: .color(red: 113, green: 181, blue: 130)),
      statusBar: .init(
        style: .light),
      navigation: .init(
        background: .black,
        tint: .white,
        shadow: .color(red: 25, green: 25, blue: 25)),
      tabBar: .init(
        background: .black,
        selectedTint: .white,
        unselectedTint: .lightGray,
        shadow: .color(red: 25, green: 25, blue: 25)),
      action: .init(
        primary: .init(
          background: .color(red: 93, green: 161, blue: 110),
          title: .white),
        secondary: .init(
          background: .clear,
          title: .color(red: 93, green: 161, blue: 110))),
      divider: .init(
        background: .color(red: 190, green: 190, blue: 190)),
      scrollIndicator: .init(
        style: .white),
      keyboard: .init(
        style: .dark)
    )
  }
  
  func createGlamourAppearance() -> Appearance {
    return Appearance(
      background: .init(
        primary: .color(red: 174, green: 47, blue: 117),
        secondary: .color(red: 177, green: 88, blue: 139)),
      text: .init(
        primary: .white,
        secondary: .color(red: 204, green: 204, blue: 204),
        disruptive: .color(red: 255, green: 45, blue: 45),
        positive: .color(red: 113, green: 181, blue: 130)),
      statusBar: .init(
        style: .light),
      navigation: .init(
        background: .color(red: 164, green: 37, blue: 107),
        tint: .color(red: 247, green: 209, blue: 229),
        shadow: .color(red: 144, green: 17, blue: 87)),
      tabBar: .init(
        background: .color(red: 164, green: 37, blue: 107),
        selectedTint: .white,
        unselectedTint: .color(red: 204, green: 204, blue: 204),
        shadow: .color(red: 144, green: 17, blue: 87)),
      action: .init(
        primary: .init(
          background: .color(red: 153, green: 23, blue: 75),
          title: .white),
        secondary: .init(
          background: .clear,
          title: .color(red: 123, green: 0, blue: 45))),
      divider: .init(
        background: .color(red: 190, green: 190, blue: 190)),
      scrollIndicator: .init(
        style: .white),
      keyboard: .init(
        style: .light)
    )
  }
}
