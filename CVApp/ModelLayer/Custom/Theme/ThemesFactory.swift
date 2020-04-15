//
//  ThemesFactory.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ThemesFactory {
  
  func createLightTheme() -> Theme {
    return Theme( type: .light, name: "Light")
  }
  
  func createDarkTheme() -> Theme {
    return Theme(type: .dark, name: "Dark")
  }
  
  func createGlamourTheme() -> Theme {
    return Theme(type: .glamour, name: "Glamour")
  }
  
  func createThemesList() -> [Theme] {
    return [
      createLightTheme(),
      createDarkTheme(),
      createGlamourTheme()
    ]
  }
}
