//
//  SkillsListVC.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit
import StoreKit

class SkillsListVC: ScreenController, SKOverlayDelegate {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Dependencies
  
  private let getCVService = GetNetworkCVsWebAPIWorker(session: .shared, requestComposer: URLRequestComposer(baseURL: "https://us-central1-cvapp-8ebd9.cloudfunctions.net"))
  
  // MARK: - Data
  
  private let userId: String?
  
  // MARK: - Life cycle
  
  init(view: SkillsListView, userId: String?) {
    selfView = view
    self.userId = userId
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCV()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.displayOverlay()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  private func loadCV() {
    getCVService.getCVs(authToken: userId ?? "userId") { [weak self] result in
      switch result {
        case .success(let cvs):
          guard let firstCV = cvs.first else { return }
          DispatchQueue.main.async {
            self?.selfView.displayCV(firstCV)
          }
        case .failure(let data): print(data)
      }
    }
  }
  
  private func displayOverlay() {
    guard let scene = view.window?.windowScene else { return }
    let configuration = SKOverlay.AppClipConfiguration(position: .bottom)
    let overlay = SKOverlay(configuration: configuration)
    overlay.delegate = self
    overlay.present(in: scene)
  }
  
  // MARK: - SKOverlayDelegate
  
  func storeOverlayDidFailToLoad(_ overlay: SKOverlay, error: Error) {
    print(error.localizedDescription)
  }
}
