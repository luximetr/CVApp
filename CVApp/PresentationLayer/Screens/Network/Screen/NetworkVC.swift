//
//  NetworkVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class NetworkVC: ScreenController, NetworkViewDelegate, ErrorAlertDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: NetworkView
  
  // MARK: - Dependencies
  
  var getNetworkCVsService: GetNetworkCVsService!
  
  // MARK: - Life cycle
  
  init(view: NetworkView) {
    selfView = view
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayCVs()
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "network.title")
  }
  
  // MARK: - CVs - Display
  
  private func displayCVs() {
    displayCachedCVs()
    loadCVs()
  }
  
  private func displayCachedCVs() {
    
  }
  
  private func loadCVs() {
    getNetworkCVsService.getCVs(completion: { [weak self] result in
      switch result {
      case .success(let CVs):
        self?.selfView.displayCVs(CVs)
      case .failure(let error):
        self?.showRepeatErrorAlert(message: error.message, onRepeat: {
          self?.loadCVs()
        })
      }
    })
  }
  
  // MARK: - CVs - Actions
  
  func didTapOnCV(_ cv: CV) {
    print(cv.userInfo.name)
  }
  
}
