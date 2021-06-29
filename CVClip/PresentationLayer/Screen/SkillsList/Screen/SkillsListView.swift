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
  
  private let avatarView = AvatarView()
  private let nameLabel = UILabel()
  private let roleLabel = UILabel()
  private let emailLabel = UILabel()
  private let lastExperienceHeaderLabel = UILabel()
  private let lastExperienceDurationLabel = UILabel()
  private let lastExperienceCompanyLabel = UILabel()
  
  // MARK: - Public
  
  // MARK: - CV - Display
  
  func displayCV(_ cv: CV) {
    avatarView.imageView.sd_setImage(with: cv.userInfo.avatarURL)
    nameLabel.text = cv.userInfo.name
    roleLabel.text = cv.userInfo.role
    emailLabel.text = cv.contacts.emails.first
    lastExperienceHeaderLabel.text = "Last experience"
    if let dateStart = cv.experience.first?.dateStart {
      lastExperienceDurationLabel.text = createExperienceYears(dateStart, endDate: cv.experience.first?.dateEnd)
    }
    lastExperienceCompanyLabel.text = cv.experience.first?.companyName
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
    setupAvatarView()
    setupNameLabel()
    setupRoleLabel()
    setupEmailLabel()
    setupLastExperienceHeaderLabel()
    setupLastExperienceDurationLabel()
    setupLastExperienceCompanyLabel()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubviews([
      avatarView,
      nameLabel,
      roleLabel,
      emailLabel,
      lastExperienceHeaderLabel,
      lastExperienceDurationLabel,
      lastExperienceCompanyLabel
    ])
    autoLayoutAvatarView()
    autoLayoutNameLabel()
    autoLayoutRoleLabel()
    autoLayoutEmailLabel()
    autoLayoutLastExperienceHeaderLabel()
    autoLayoutLastExperienceDurationLabel()
    autoLayoutLastExperienceCompanyLabel()
  }
  
  // MARK: - Setup avatarView
  
  private func setupAvatarView() {
    
  }
  
  private func autoLayoutAvatarView() {
    let side: CGFloat = 200
    avatarView.snp.makeConstraints { make in
      make.height.width.equalTo(side)
      make.centerX.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom).offset(14)
    }
    avatarView.layer.masksToBounds = true
    avatarView.layer.cornerRadius = side / 2
  }
  
  // MARK: - Setup nameLabel
  
  private func setupNameLabel() {
    nameLabel.textColor = .black
  }
  
  private func autoLayoutNameLabel() {
    nameLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().inset(24)
      make.top.equalTo(avatarView.snp.bottom).offset(10)
    }
  }
  
  // MARK: - Setup roleLabel
  
  private func setupRoleLabel() {
    roleLabel.textColor = .black
  }
  
  private func autoLayoutRoleLabel() {
    roleLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(nameLabel)
      make.top.equalTo(nameLabel.snp.bottom).offset(5)
    }
  }
  
  // MARK: - Setup emailLabel
  
  private func setupEmailLabel() {
    emailLabel.textColor = .black
  }
  
  private func autoLayoutEmailLabel() {
    emailLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(roleLabel)
      make.top.equalTo(roleLabel.snp.bottom).offset(5)
    }
  }
  
  // MARK: - Setup lastExperienceHeaderLabel
  
  private func setupLastExperienceHeaderLabel() {
    lastExperienceHeaderLabel.textColor = .black
  }
  
  private func autoLayoutLastExperienceHeaderLabel() {
    lastExperienceHeaderLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(emailLabel)
      make.top.equalTo(emailLabel.snp.bottom).offset(10)
    }
  }
  
  // MARK: - Setup lastExperienceDurationLabel
  
  private func setupLastExperienceDurationLabel() {
    lastExperienceDurationLabel.textColor = .black
  }
  
  private func autoLayoutLastExperienceDurationLabel() {
    lastExperienceDurationLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(lastExperienceHeaderLabel)
      make.top.equalTo(lastExperienceHeaderLabel.snp.bottom).offset(5)
    }
  }
  
  // MARK: - Setup lastExperienceCompanyLabel
  
  private func setupLastExperienceCompanyLabel() {
    lastExperienceCompanyLabel.textColor = .black
  }
  
  private func autoLayoutLastExperienceCompanyLabel() {
    lastExperienceCompanyLabel.snp.makeConstraints { make in
      make.leading.trailing.equalTo(lastExperienceDurationLabel)
      make.top.equalTo(lastExperienceDurationLabel.snp.bottom).offset(5)
    }
  }
  
}
