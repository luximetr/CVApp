//
//  SkillsListVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListVCInput: class {
  func displayUserInfo()
  func displayContactInfo()
  func displayExperience()
  func displayNumbers()
  func displaySkills()
}

protocol SkillsListVCOutput {
  
}

class SkillsListVC: ScreenController, SkillsListVCInput {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Dependencies
  
  var output: SkillsListVCOutput!
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  // MARK: - Life cycle
  
  init(view: SkillsListView) {
    selfView = view
    super.init()
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    navigationItem.title = "Skills"
    view.backgroundColor = .purple
    tableViewController.tableView = selfView.tableView
  }
  
  func displayUserInfo() {
    
  }
  
  func displayContactInfo() {
    
  }
  
  func displayExperience() {
    
  }
  
  func displayNumbers() {
    
  }
  
  func displaySkills() {
    
  }
  
}
