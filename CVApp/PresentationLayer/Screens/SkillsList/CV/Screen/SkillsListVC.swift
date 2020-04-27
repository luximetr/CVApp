//
//  SkillsListVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListVCOutput {
  func didTapOnUserInfo(in vc: UIViewController, cvId: CVIdType, userInfo: UserInfo)
}

class SkillsListVC: ScreenController, CurrentUserNameChangedObserver, CVAvatarChangedObserver, CurrentUserRoleChangedObserver, ErrorAlertDisplayable {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  private let userDetailsCell = UserDetailsItemCellConfigurator()
  private let experienceHeaderCell = HeaderItemCellConfigurator()
  private let numbersHeaderCell = HeaderItemCellConfigurator()
  private let skillsHeaderCell = HeaderItemCellConfigurator()
  
  // MARK: - Dependencies
  
  var output: SkillsListVCOutput!
  var changeUserNameService: ChangeUserNameService!
  var getCVService: GetCVService!
  var imageSetService: ImageSetFromURLService!
  var callPhoneService: CallPhoneService!
  var openLinkService: OpenLinkExternallyService!
  var sendMailService: SendMailService!
  
  // MARK: - Data
  
  private var cv: CV?
  
  // MARK: - Life cycle
  
  init(view: SkillsListView) {
    selfView = view
    super.init(screenView: view)
  }
  
  // MARK: - View - Life cycle
  
  override func loadView() {
    view = selfView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupObservers()
    displayCV()
  }
  
  // MARK: - View - Setup
  
  private func setupView() {
    tableViewController.tableView = selfView.tableView
  }
  
  private func setupObservers() {
    changeUserNameService.addObserver(self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "skills_list.title")
  }
  
  // MARK: - CV - Display
  
  private func displayCV() {
    displayCachedCV()
    loadCV()
  }
  
  private func displayCachedCV() {
    guard let cachedCV = getCVService.getCachedCV() else { return }
    cv = cachedCV
    displayCV(cachedCV)
  }
  
  private func loadCV() {
    getCVService.getCV(completion: { [weak self] result in
      switch result {
      case .success(let cv):
        self?.displayCV(cv)
      case .failure(let error):
        self?.showRepeatErrorAlert(message: error.message, onRepeat: {
          self?.loadCV()
        })
      }
    })
  }
  
  private func displayCV(_ cv: CV) {
    self.cv = cv
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
  
  // MARK: - User info - Create cell
  
  private func createUserInfoCell(_ userInfo: UserInfo) -> TableCellConfigurator {
    displayUserAvatar(userInfo.avatarURL)
    displayUserName(userInfo.name)
    displayUserRole(userInfo.role)
    userDetailsCell.tapAction = { [weak self] in self?.didTapOnUserInfo() }
    userDetailsCell.appearanceService = currentAppearanceService
    userDetailsCell.imageSetService = imageSetService
    return userDetailsCell
  }
  
  private func createContactsCells(_ contacts: Contacts) -> [TableCellConfigurator] {
    var result: [TableCellConfigurator] = []
    result.append(contentsOf: createPhonesCells(contacts.phones))
    result.append(contentsOf: createEmailsCells(contacts.emails))
    result.append(contentsOf: createMessangerCells(contacts.messangers))
    return result
  }
  
  // MARK: - User info - Avatar - Display
  
  private func displayUserAvatar(_ imageURL: URL?) {
    userDetailsCell.avatarURL.value = imageURL
  }
  
  // MARK: - User info - Avatar - Changed
  // CurrentUserAvatarChangedObserver
  
  func cvAvatarChanged(_ avatarURL: URL) {
    cv?.userInfo.avatarURL = avatarURL
    displayUserAvatar(avatarURL)
  }
  
  // MARK: - User info - Name - Display
   
  private func displayUserName(_ name: String) {
    userDetailsCell.name.value = name
  }
   
  // MARK: - User info - Name - Changed
  // CurrentUserNameChangedObserver
   
  func currentUserNameChanged(_ name: String) {
    cv?.userInfo.name = name
    displayUserName(name)
  }
  
  // MARK: - User info - Role - Display
  
  private func displayUserRole(_ role: String) {
    userDetailsCell.role.value = role
  }
  
  // MARK: - User info - Role - Changed
  
  func currentUserRoleChanged(_ role: String) {
    cv?.userInfo.role = role
    displayUserRole(role)
  }
  
  // MARK: - User info - Actions
  
  private func didTapOnUserInfo() {
    guard let userInfo = cv?.userInfo, let cvId = cv?.id else { return }
    output.didTapOnUserInfo(in: self, cvId: cvId, userInfo: userInfo)
  }
  
  // MARK: - Phones - Create cells
  
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
    cell.tapAction = { [weak self] in self?.didTapOnPhone(phone) }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Phones - Actions
  
  private func didTapOnPhone(_ phone: String) {
    callPhoneService.callPhoneNumber(phone)
  }
  
  // MARK: - Emails - Create cells
  
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
    cell.tapAction = { [weak self] in self?.didTapOnEmail(email) }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Emails - Actions
  
  private func didTapOnEmail(_ email: String) {
    sendMailService.sendMail(to: email)
  }
  
  // MARK: - Messangers - Create cells
  
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
    cell.tapAction = { [weak self] in self?.didTapOnMessanger(messanger) }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func getMessangerIcon(_ messangerType: MessangerContactType) -> UIImage {
    switch messangerType {
    case .telegram: return AssetsFactory.telegram
    }
  }
  
  // MARK: - Messangers - Actions
  
  private func didTapOnMessanger(_ messanger: MessangerContact) {
    openLinkService.openURL(messanger.link)
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
