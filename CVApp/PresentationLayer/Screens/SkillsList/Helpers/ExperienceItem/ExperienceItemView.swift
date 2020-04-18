//
//  ExperienceItemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ExperienceItemView: InitView {
  
  // MARK: - UI elements
  
  let yearsLabel = UILabel()
  let companyLabel = UILabel()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupYearsLabel()
    setupCompanyLabel()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      yearsLabel,
      companyLabel
    ])
    autoLayoutYearsLabel()
    autoLayoutCompanyLabel()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setSelf(appearance)
    setYearsLabel(appearance: appearance)
    setCompanyLabel(appearance: appearance)
  }
  
  // MARK: - Setup self
  
  private func setSelf(_ appearance: Appearance) {
    backgroundColor = appearance.primaryBackgroundColor
  }
  
  // MARK: - Setup yearsLabel
  
  private func setupYearsLabel() {
    yearsLabel.numberOfLines = 1
    yearsLabel.font = .font(ofSize: 18)
    yearsLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    yearsLabel.setContentHuggingPriority(.required, for: .horizontal)
  }
  
  private func setYearsLabel(appearance: Appearance) {
    yearsLabel.textColor = appearance.secondaryTextColor
  }
  
  private func autoLayoutYearsLabel() {
    yearsLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.top.equalToSuperview().offset(7)
      make.bottom.equalToSuperview().inset(15)
    }
  }
  
  // MARK: - Setup companyLabel
  
  private func setupCompanyLabel() {
    companyLabel.numberOfLines = 1
    companyLabel.font = .font(ofSize: 16)
  }
  
  private func setCompanyLabel(appearance: Appearance) {
    companyLabel.textColor = appearance.primaryTextColor
  }
  
  private func autoLayoutCompanyLabel() {
    companyLabel.snp.makeConstraints { make in
      make.leading.equalTo(yearsLabel.snp.trailing).offset(5)
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalTo(yearsLabel)
    }
  }
  
}
