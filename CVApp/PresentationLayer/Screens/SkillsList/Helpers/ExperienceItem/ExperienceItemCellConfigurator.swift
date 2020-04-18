//
//  ExperienceItemCellConfigurator.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ExperienceItemCellConfigurator: ContainerTableCellConfigurator<ExperienceItemView> {
  
  // MARK: - Cell data
  
  override var cellId: String { return "experienceCell" }
  
  // MARK: - Data
  
  let years: Bindable<String>
  let company: Bindable<String>
  
  // MARK: - Life cycle
  
  override init() {
    years = Bindable("")
    company = Bindable("")
    super.init()
    bindView()
  }
  
  // MARK: - Bind view
  
  private func bindView() {
    years.bind(listener: { [weak self] years in
      guard let view = self?.findView() else { return }
      self?.setupView(view, years: years)
    })
    company.bind(listener: { [weak self] company in
      guard let view = self?.findView() else { return }
      self?.setupView(view, company: company)
    })
  }
  
  // MARK: - Setup view - UI
  
  override func setupCellViewUI(_ view: ViewType) {
    super.setupCellViewUI(view)
    setupView(view, years: years.value)
    setupView(view, company: company.value)
  }
  
  private func setupView(_ view: ViewType, years: String) {
    view.yearsLabel.text = years
  }
  
  private func setupView(_ view: ViewType, company: String) {
    view.companyLabel.text = company
  }
}
