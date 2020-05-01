//
//  NetworkVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 29/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol NetworkCVOutput: class {
  func didTapOnCV(_ cv: CV, in vc: UIViewController)
}

class NetworkVC: ScreenController, NetworkViewDelegate {
  
  // MARK: - UI elements
  
  private let selfView: NetworkView
  
  // MARK: - Dependencies
  
  var output: NetworkCVOutput?
  var getNetworkCVsService: GetNetworkCVsService!
  var showErrorAlertService: ShowErrorAlertService!
  
  // MARK: - Data
  
  private var CVs: [CV] = []
  
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
    CVs = getNetworkCVsService.getCachedCVs()
    selfView.displayCVs(CVs)
  }
  
  private func loadCVs() {
    showLoaderIfNeeded()
    getNetworkCVsService.getCVs(completion: { [weak self] result in
      guard let strongSelf = self else { return }
      self?.selfView.hideFullScreenLoader()
      switch result {
      case .success(let CVs):
        self?.selfView.displayCVs(CVs)
      case .failure(let error):
        strongSelf.showErrorAlertService.showRepeatErrorAlert(
          message: error.message, in: strongSelf, onRepeat: {
            self?.loadCVs()
        })
      }
    })
  }
  
  private func showLoaderIfNeeded() {
    guard getNeedShowLoader() else { return }
    selfView.showFullScreenLoader()
  }
  
  private func getNeedShowLoader() -> Bool {
    return CVs.isEmpty
  }
  
  // MARK: - CVs - Actions
  
  func didTapOnCV(_ cv: CV) {
    output?.didTapOnCV(cv, in: self)
  }
  
}
