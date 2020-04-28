//
//  FullScreenLoaderDisplayable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 28/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol FullScreenLoaderDisplayable {
  var loaderView: FullScreenLoaderView { get }
  func placeFullScreenLoader(_ view: FullScreenLoaderView)
  func setFullScreenLoader(appearance: Appearance)
  func showFullScreenLoader()
  func hideFullScreenLoader()
}

extension FullScreenLoaderDisplayable where Self: UIView {
  
  func showFullScreenLoader() {
    addSubview(loaderView)
    placeFullScreenLoader(loaderView)
  }
  
  func hideFullScreenLoader() {
    loaderView.removeFromSuperview()
  }
  
  func setFullScreenLoader(appearance: Appearance) {
    loaderView.setAppearance(appearance)
  }
  
}
