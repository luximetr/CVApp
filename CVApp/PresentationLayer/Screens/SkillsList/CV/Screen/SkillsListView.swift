//
//  SkillsListView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListViewDelegate: class {
  func didTapOnUserInfo()
  func didTapOnPhone(_ phone: String)
  func didTapOnEmail(_ email: String)
  func didTapOnMessanger(_ messanger: MessangerContact)
}

class SkillsListView: ScreenNavigationBarView, FullScreenLoaderDisplayable {
  
  // MARK: - UI elements
  
  let loaderView = FullScreenLoaderView()
  private let tableView = UITableView()
  
  // MARK: - Dependencies
  
  weak var delegate: SkillsListViewDelegate?
  var currentAppearanceService: AppearanceService!
  var imageSetService: ImageSetFromURLService!
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  private let userDetailsCell = UserDetailsItemCellConfigurator()
  private let experienceHeaderCell = HeaderItemCellConfigurator()
  private let numbersHeaderCell = HeaderItemCellConfigurator()
  private let skillsHeaderCell = HeaderItemCellConfigurator()
  
  // MARK: - Setup
  
  override func setup() {
    super.setup()
    setupTableView()
    setupTableViewController()
  }
  
  // MARK: - AutoLayout
  
  override func autoLayout() {
    super.autoLayout()
    addSubview(tableView)
    autoLayoutTableView()
  }
  
  // MARK: - Appearance
  
  override func setAppearance(_ appearance: Appearance) {
    super.setAppearance(appearance)
    setTableView(appearance: appearance)
    setFullScreenLoader(appearance: appearance)
  }
  
  // MARK: - Setup tableView
  
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  private func setTableView(appearance: Appearance) {
    tableView.backgroundColor = appearance.primaryBackgroundColor
  }
  
  private func autoLayoutTableView() {
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(navigationBarView.snp.bottom)
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Setup tableViewController
  
  private func setupTableViewController() {
    tableViewController.tableView = tableView
  }
  
  // MARK: - Setup loader
  
  func placeFullScreenLoader(_ view: FullScreenLoaderView) {
    loaderView.snp.makeConstraints { make in
      make.edges.equalTo(tableView)
    }
  }
  
  // MARK: - CV - Display
  
  func displayCV(_ cv: CV) {
    let cells = createCells(cv: cv)
    tableViewController.reloadItems(cells, animated: false)
  }
  
  // MARK: - CV - Create cells
  
  private func createCells(cv: CV) -> [TableCellConfigurator] {
    var result: [TableCellConfigurator] = []
    result.append(createUserInfoCell(cv.userInfo))
    result.append(contentsOf: createContactsCells(cv.contacts))
    result.append(contentsOf: createExperienceCells(cv.experience))
    result.append(contentsOf: createNumbersCells(cv.numbers))
    result.append(contentsOf: createSkillsCells(skillGroups: cv.skills))
    return result
  }
  
  // MARK: - UserInfo - Display
  
  func displayUserAvatar(_ imageURL: URL?) {
    userDetailsCell.avatarURL.value = imageURL
  }
  
  func displayUserName(_ name: String) {
    userDetailsCell.name.value = name
  }
  
  func displayUserRole(_ role: String) {
    userDetailsCell.role.value = role
  }
  
  // MARK: - User info - Create cell
  
  private func createUserInfoCell(_ userInfo: UserInfo) -> TableCellConfigurator {
    displayUserName(userInfo.name)
    displayUserRole(userInfo.role)
    displayUserAvatar(userInfo.avatarURL)
    userDetailsCell.tapAction = { [weak self] in
      self?.delegate?.didTapOnUserInfo()
    }
    userDetailsCell.appearanceService = currentAppearanceService
    userDetailsCell.imageSetService = imageSetService
    return userDetailsCell
  }
  
  // MARK: - Contacts - Create cells
  
  private func createContactsCells(_ contacts: Contacts) -> [TableCellConfigurator] {
    var result: [TableCellConfigurator] = []
    result.append(contentsOf: createPhonesCells(contacts.phones))
    result.append(contentsOf: createEmailsCells(contacts.emails))
    result.append(contentsOf: createMessangerCells(contacts.messangers))
    return result
  }
  
  // MARK: - Contacts - Phones - Create cells
  
  private func createPhonesCells(_ phones: [String]) -> [TableCellConfigurator] {
    let sortedPhones = sortPhones(phones)
    return sortedPhones.map { createPhoneCell($0) }
  }
  
  private func sortPhones(_ phones: [String]) -> [String] {
    return phones.sorted(by: < )
  }
  
  private func createPhoneCell(_ phone: String) -> TableCellConfigurator {
    let cell = ContactItemCellConfigurator(icon: AssetsFactory.phone)
    cell.title.value = phone
    cell.tapAction = { [weak self] in
      self?.delegate?.didTapOnPhone(phone)
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Contacts - Emails - Create cells
  
  private func createEmailsCells(_ emails: [String]) -> [TableCellConfigurator] {
    let sortedEmails = sortEmails(emails)
    return sortedEmails.map { createEmailCell($0) }
  }
  
  private func sortEmails(_ emails: [String]) -> [String] {
    return emails.sorted(by: < )
  }
  
  private func createEmailCell(_ email: String) -> TableCellConfigurator {
    let cell = ContactItemCellConfigurator(icon: AssetsFactory.email)
    cell.title.value = email
    cell.tapAction = { [weak self] in
      self?.delegate?.didTapOnEmail(email)
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Contacts - Messangers - Create cells
  
  private func createMessangerCells(_ messangers: [MessangerContact]) -> [TableCellConfigurator] {
    return messangers.map { createMessangerCell($0) }
  }
  
  private func sortMessangers(_ messangers: [MessangerContact]) -> [MessangerContact] {
    return messangers.sorted(by: { $0.type.rawValue < $1.type.rawValue })
  }
  
  private func createMessangerCell(_ messanger: MessangerContact) -> TableCellConfigurator {
    let icon = getMessangerIcon(messanger.type)
    let cell = ContactItemCellConfigurator(icon: icon)
    cell.title.value = messanger.link.absoluteString
    cell.tapAction = { [weak self] in
      self?.delegate?.didTapOnMessanger(messanger)
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func getMessangerIcon(_ messangerType: MessangerContactType) -> UIImage {
    switch messangerType {
    case .telegram: return AssetsFactory.telegram
    case .linkedin: return AssetsFactory.linkedin
    }
  }
  
  // MARK: - Experience - Create cells
  
  private func createExperienceCells(_ experiences: [Experience]) -> [TableCellConfigurator] {
    let headerCell = createExperienceHeaderCell()
    let sortedExperiences = sortExperiences(experiences)
    let experiencesCells = sortedExperiences.map { createExperienceCell($0) }
    return [headerCell] + experiencesCells
  }
  
  private func createExperienceHeaderCell() -> TableCellConfigurator {
    experienceHeaderCell.title.value = "Experience"
    experienceHeaderCell.appearanceService = currentAppearanceService
    return experienceHeaderCell
  }
  
  private func sortExperiences(_ experiences: [Experience]) -> [Experience] {
    return experiences.sorted(by: { $0.dateStart < $1.dateStart })
  }
  
  private func createExperienceCell(_ experience: Experience) -> TableCellConfigurator {
    let cell = ExperienceItemCellConfigurator()
    cell.years.value = createExperienceYears(experience.dateStart, endDate: experience.dateEnd)
    cell.company.value = "- \(experience.companyName)"
    cell.appearanceService = currentAppearanceService
    return cell
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
  
  // MARK: - Numbers - Create cells
  
  private func createNumbersCells(_ numbers: [UserNumber]) -> [TableCellConfigurator] {
    let headerCell = createNumbersHeader()
    let sortedNumbers = sortNumbers(numbers)
    let numbersCells = sortedNumbers.map { createNumbersCell($0) }
    return [headerCell] + numbersCells
  }
  
  private func sortNumbers(_ numbers: [UserNumber]) -> [UserNumber] {
    return numbers.sorted(by: { $0.value < $1.value })
  }
  
  private func createNumbersHeader() -> TableCellConfigurator {
    numbersHeaderCell.title.value = "Me in Numbers"
    numbersHeaderCell.appearanceService = currentAppearanceService
    return numbersHeaderCell
  }
  
  private func createNumbersCell(_ number: UserNumber) -> TableCellConfigurator {
    let valueString = createNumberString(value: number.value)
    let cell = NumbersItemCellConfigurator(number: valueString)
    cell.title.value = number.title
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func createNumberString(value: Int) -> String {
    let formatter = NumberFormatter()
    return formatter.string(from: NSNumber(value: value)) ?? ""
  }
  
  // MARK: - Skills - Create cells
  
  private func createSkillsCells(skillGroups: [SkillGroup]) -> [TableCellConfigurator] {
    let headerCell = createSkillsHeaderCell()
    let skillsCells = createSkillsGroupsCells(skillGroups: skillGroups)
    return [headerCell] + skillsCells
  }
  
  private func createSkillsHeaderCell() -> TableCellConfigurator {
    let cell = skillsHeaderCell
    cell.title.value = "Skills"
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func createSkillsGroupsCells(skillGroups: [SkillGroup]) -> [TableCellConfigurator] {
    let sortedSkillGroups = sortSkillGroups(skillGroups)
    let cells = sortedSkillGroups.map { createSkillsGroupCells(skillGroup: $0) }
    return Array(cells.joined())
  }
  
  private func sortSkillGroups(_ skillGroups: [SkillGroup]) -> [SkillGroup] {
    return skillGroups.sorted(by: { $0.name < $1.name })
  }
  
  private func createSkillsGroupCells(skillGroup: SkillGroup) -> [TableCellConfigurator] {
    let itemCell = createSkillItemCell(skillGroup: skillGroup)
    let sortedSkills = sortSkills(skillGroup.skills)
    let subitemsCells = createSkillSubitemsCells(skills: sortedSkills)
    return [itemCell] + subitemsCells
  }
  
  private func sortSkills(_ skills: [String]) -> [String] {
    return skills.sorted(by: < )
  }
  
  private func createSkillItemCell(skillGroup: SkillGroup) -> TableCellConfigurator {
    let cell = SkillItemCellConfigurator()
    cell.title.value = skillGroup.name
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func createSkillSubitemsCells(skills: [String]) -> [TableCellConfigurator] {
    return skills.map { createSkillSubitemCell(skill: $0) }
  }
  
  private func createSkillSubitemCell(skill: String) -> TableCellConfigurator {
    let cell = SkillSubitemCellConfigurator()
    cell.title.value = skill
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
}
