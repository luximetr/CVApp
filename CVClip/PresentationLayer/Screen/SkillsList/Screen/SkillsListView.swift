//
//  SkillsListView.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SDWebImage

class SkillsListView: ScreenNavigationBarView {
  
  // MARK: - UI elements
  
  private let scrollView = UIScrollView()
  private let scrollContentView = UIView()
  private let avatarView = AvatarView()
  private let nameLabel = UILabel()
  private let roleLabel = UILabel()
  private let emailLabel = UILabel()
  private let experienceHeaderLabel = UILabel()
  private let experienceStackView = UIStackView()
  
  // MARK: - Public
  
  // MARK: - CV - Display
  
  func displayCV(_ cv: CV) {
    avatarView.imageView.sd_setImage(with: cv.userInfo.avatarURL)
    nameLabel.text = cv.userInfo.name
    roleLabel.text = cv.userInfo.role
    emailLabel.text = cv.contacts.emails.first
    experienceHeaderLabel.text = "Experience"
    displayExperience(cv.experience)
  }
  
  private func displayExperience(_ experience: [Experience]) {
    experienceStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    let views = experience.map { experience -> ExperienceItemView in
      let view = ExperienceItemView()
      view.companyLabel.text = experience.companyName
      view.yearsLabel.text = createExperienceYears(experience.dateStart, endDate: experience.dateEnd)
      view.backgroundColor = ColorsFactory.backgroundPrimary
      view.companyLabel.textColor = ColorsFactory.textPrimary
      view.yearsLabel.font = UIFont.font(ofSize: 15)
      view.yearsLabel.textColor = ColorsFactory.textSecondary
      return view
    }
    views.forEach { experienceStackView.addArrangedSubview($0) }
  }
  
  private func createExperienceYears(_ startDate: Date, endDate: Date?) -> String {
    let startDateString = createExperienceStartDateString(startDate)
    let endDateString = createExperienceEndDateString(endDate)
    return "\(startDateString) - \(endDateString)"
  }
  
  private func createExperienceStartDateString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: date)
  }
  
  private func createExperienceEndDateString(_ date: Date?) -> String {
    if let date = date {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy"
      return formatter.string(from: date)
    } else {
      return "nowadays"
    }
  }
  
  // MARK: - Private
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupNavigationBarView()
    setupScrollView()
    setupScrollContentView()
    setupAvatarView()
    setupNameLabel()
    setupRoleLabel()
    setupEmailLabel()
    setupExperienceHeaderLabel()
    setupExperienceStackView()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(scrollView)
    scrollView.addSubview(scrollContentView)
    scrollContentView.addSubviews([
      avatarView,
      nameLabel,
      roleLabel,
      emailLabel,
      experienceHeaderLabel,
      experienceStackView
    ])
    autoLayoutScrollView()
    autoLayoutScrollContentView()
    autoLayoutAvatarView()
    autoLayoutNameLabel()
    autoLayoutRoleLabel()
    autoLayoutEmailLabel()
    autoLayoutExperienceHeaderLabel()
    autoLayoutExperienceStackView()
  }
  
  // MARK: - Setup navigationBarView
  
  private func setupNavigationBarView() {
    statusBarView.backgroundColor = ColorsFactory.backgroundPrimary
    navigationBarView.backgroundColor = ColorsFactory.backgroundPrimary
  }
  
  // MARK: - Setup scrollView
  
  private func setupScrollView() {
    scrollView.backgroundColor = ColorsFactory.backgroundPrimary
  }
  
  private func autoLayoutScrollView() {
    scrollView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
    }
  }
  
  // MARK: - Setup scrollContentView
  
  private func setupScrollContentView() {
    scrollContentView.backgroundColor = ColorsFactory.backgroundPrimary
  }
  
  private func autoLayoutScrollContentView() {
    scrollContentView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.width.equalTo(scrollView)
    }
  }
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func autoLayoutAvatarView() {
    let side: CGFloat = 200
    avatarView.snp.makeConstraints { make in
      make.height.width.equalTo(side)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(14)
    }
    avatarView.layer.masksToBounds = true
    avatarView.layer.cornerRadius = side / 2
  }
  
  // MARK: - Setup nameLabel
  
  private func setupNameLabel() {
    nameLabel.font = UIFont.font(ofSize: 26, weight: .regular, family: .system)
    nameLabel.textColor = ColorsFactory.textPrimary
  }
  
  private func autoLayoutNameLabel() {
    nameLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(avatarView.snp.bottom).offset(20)
    }
  }
  
  // MARK: - Setup roleLabel
  
  private func setupRoleLabel() {
    roleLabel.textColor = ColorsFactory.textSecondary
  }
  
  private func autoLayoutRoleLabel() {
    roleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(nameLabel)
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
    }
  }
  
  // MARK: - Setup emailLabel
  
  private func setupEmailLabel() {
    emailLabel.textColor = ColorsFactory.textPrimary
  }
  
  private func autoLayoutEmailLabel() {
    emailLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(roleLabel)
      make.top.equalTo(roleLabel.snp.bottom).offset(5)
    }
  }
  
  // MARK: - Setup experienceHeaderLabel
  
  private func setupExperienceHeaderLabel() {
    experienceHeaderLabel.font = UIFont.font(ofSize: 20, weight: .regular, family: .system)
    experienceHeaderLabel.textColor = ColorsFactory.textPrimary
  }
  
  private func autoLayoutExperienceHeaderLabel() {
    experienceHeaderLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(emailLabel)
      make.top.equalTo(emailLabel.snp.bottom).offset(25)
    }
  }
  
  // MARK: - Setup experienceStackView
  
  private func setupExperienceStackView() {
    experienceStackView.axis = .vertical
    experienceStackView.alignment = .fill
  }
  
  private func autoLayoutExperienceStackView() {
    experienceStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(experienceHeaderLabel.snp.bottom).offset(10)
      make.bottom.equalToSuperview()
    }
  }
  
}
