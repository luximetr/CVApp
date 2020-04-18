//
//  SkillsListVC.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

protocol SkillsListVCOutput {
  
}

class SkillsListVC: ScreenController, CurrentUserNameChangedObserver {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
  // MARK: - Controllers
  
  private let tableViewController = TableViewController()
  
  private let userDetailsCell = UserDetailsItemCellConfigurator()
  
  // MARK: - Dependencies
  
  var output: SkillsListVCOutput!
  var changeUserNameService: ChangeUserNameService!
  var getCVService: GetCVService!
  
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
    changeUserNameService.addChangeCurrentNameChanged(observer: self)
  }
  
  // MARK: - View - Text values
  
  override func displayTextValues() {
    super.displayTextValues()
    selfView.navigationBarView.titleLabel.text = getLocalizedString(key: "skills_list.title")
  }
  
  // MARK: - Data source - Setup
  
  private func displaySkillsList() {
    displayCurrentUserName("User name")
    userDetailsCell.role.value = "Middle iOS developer"
    userDetailsCell.tapAction = {
      print("open settings")
    }
    userDetailsCell.appearanceService = currentAppearanceService
    
    let phoneCell = ContactItemCellConfigurator(icon: AssetsFactory.phone)
    phoneCell.title.value = "+6590378917"
    phoneCell.tapAction = {
      print("call phone")
    }
    phoneCell.appearanceService = currentAppearanceService
    
    let emailCell = ContactItemCellConfigurator(icon: AssetsFactory.email)
    emailCell.title.value = "job.aleksandrorlov@gmail.com"
    emailCell.tapAction = {
      print("send mail")
    }
    emailCell.appearanceService = currentAppearanceService
    
    let telegramCell = ContactItemCellConfigurator(icon: AssetsFactory.telegram)
    telegramCell.title.value = "https://t.me/luximetr"
    telegramCell.tapAction = {
      print("open in Telegram")
    }
    telegramCell.appearanceService = currentAppearanceService
    
    let experienceHeaderCell = HeaderItemCellConfigurator()
    experienceHeaderCell.title.value = "Experience"
    experienceHeaderCell.appearanceService = currentAppearanceService
    
    let experienceCell1 = ExperienceItemCellConfigurator()
    experienceCell1.years.value = "2016-2018"
    experienceCell1.company.value = "- Brander"
    experienceCell1.appearanceService = currentAppearanceService
    
    let experienceCell2 = ExperienceItemCellConfigurator()
    experienceCell2.years.value = "2018-2020"
    experienceCell2.company.value = "- Deskera"
    experienceCell2.appearanceService = currentAppearanceService
    
    let experienceCell3 = ExperienceItemCellConfigurator()
    experienceCell3.years.value = "2020-nowadays"
    experienceCell3.company.value = "- Google"
    experienceCell3.appearanceService = currentAppearanceService
    
    let meInNumbersHeaderCell = HeaderItemCellConfigurator()
    meInNumbersHeaderCell.title.value = "Me in numbers"
    meInNumbersHeaderCell.appearanceService = currentAppearanceService
    
    let numbersCell1 = NumbersItemCellConfigurator(number: "3")
    numbersCell1.title.value = "years in iOS development"
    numbersCell1.appearanceService = currentAppearanceService
    
    let numbersCell2 = NumbersItemCellConfigurator(number: "11")
    numbersCell2.title.value = "projects I was involved"
    numbersCell2.appearanceService = currentAppearanceService
    
    let skillsHeaderCell = HeaderItemCellConfigurator()
    skillsHeaderCell.title.value = "Skills"
    skillsHeaderCell.appearanceService = currentAppearanceService
    
    let skillItemCell1 = SkillItemCellConfigurator()
    skillItemCell1.title.value = "UI"
    skillItemCell1.appearanceService = currentAppearanceService
    
    let skillUISubitemCell1 = SkillSubitemCellConfigurator()
    skillUISubitemCell1.title.value = "SnapKit"
    skillUISubitemCell1.appearanceService = currentAppearanceService
    
    let skillUISubitemCell2 = SkillSubitemCellConfigurator()
    skillUISubitemCell2.title.value = "PureLayout"
    skillUISubitemCell2.appearanceService = currentAppearanceService
    
    let skillItemCell2 = SkillItemCellConfigurator()
    skillItemCell2.title.value = "Networking"
    skillItemCell2.appearanceService = currentAppearanceService
    
    let skillNetworkingSubitemCell1 = SkillSubitemCellConfigurator()
    skillNetworkingSubitemCell1.title.value = "Alamofire"
    skillNetworkingSubitemCell1.appearanceService = currentAppearanceService
    
    let skillNetworkingSubitemCell2 = SkillSubitemCellConfigurator()
    skillNetworkingSubitemCell2.title.value = "NSURLSession"
    skillNetworkingSubitemCell2.appearanceService = currentAppearanceService
    
    let dataSource = [
      userDetailsCell,
      phoneCell,
      emailCell,
      telegramCell,
      experienceHeaderCell,
      experienceCell1,
      experienceCell2,
      experienceCell3,
      meInNumbersHeaderCell,
      numbersCell1,
      numbersCell2,
      skillsHeaderCell,
      skillItemCell1,
      skillUISubitemCell1,
      skillUISubitemCell2,
      skillItemCell2,
      skillNetworkingSubitemCell1,
      skillNetworkingSubitemCell2
    ]
    
    tableViewController.reloadItems(dataSource)
  }
  
  // MARK: - User data - Display
 
  // MARK: - Display user name
  
  private func displayCurrentUserName(_ name: String) {
    userDetailsCell.name.value = name
  }
  
  // CurrentUserNameChangedObserver
  
  func currentUserNameChanged(_ name: String) {
    displayCurrentUserName(name)
  }
  
  // MARK: - CV - Display
  
  private func displayCV() {
    loadCV()
  }
  
  private func loadCV() {
    getCVService.getCV(completion: { [weak self] result in
      switch result {
      case .success(let cv):
        self?.displayCV(cv)
      case .failure(let error):
        print(error)
      }
    })
  }
  
  private func displayCV(_ cv: CV) {
    let cells = createCells(cv: cv)
    tableViewController.reloadItems(cells, animated: false)
  }
  
  // MARK: - CV - Create cells
  
  private func createCells(cv: CV) -> [TableCellConfigurator] {
    var result: [TableCellConfigurator] = []
    result.append(createUserInfoCell(cv.userInfo))
    result.append(contentsOf: createContactsCells(cv.contacts))
    return result
  }
  
  // MARK: - User info - Create cell
  
  private func createUserInfoCell(_ userInfo: UserInfo) -> TableCellConfigurator {
    userDetailsCell.avatarURL.value = userInfo.avatarURL
    userDetailsCell.name.value = userInfo.name
    userDetailsCell.role.value = userInfo.role
    userDetailsCell.appearanceService = currentAppearanceService
    return userDetailsCell
  }
  
  private func createContactsCells(_ contacts: Contacts) -> [TableCellConfigurator] {
    var result: [TableCellConfigurator] = []
    result.append(contentsOf: createPhonesCells(contacts.phones))
    result.append(contentsOf: createEmailsCells(contacts.emails))
    result.append(contentsOf: createMessangerCells(contacts.messangers))
    return result
  }
  
  // MARK: - Phones - Create cells
  
  private func createPhonesCells(_ phones: [String]) -> [TableCellConfigurator] {
    return phones.map { createPhoneCell($0) }
  }
  
  private func createPhoneCell(_ phone: String) -> TableCellConfigurator {
    let cell = ContactItemCellConfigurator(icon: AssetsFactory.phone)
    cell.title.value = phone
    cell.tapAction = {
      print("call \(phone)")
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Emails - Create cells
  
  private func createEmailsCells(_ emails: [String]) -> [TableCellConfigurator] {
    return emails.map { createEmailCell($0) }
  }
  
  private func createEmailCell(_ email: String) -> TableCellConfigurator {
    let cell = ContactItemCellConfigurator(icon: AssetsFactory.email)
    cell.title.value = email
    cell.tapAction = {
      print("send mail to \(email)")
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  // MARK: - Messangers - Create cells
  
  private func createMessangerCells(_ messangers: [MessangerContact]) -> [TableCellConfigurator] {
    return messangers.map { createMessangerCell($0) }
  }
  
  private func createMessangerCell(_ messanger: MessangerContact) -> TableCellConfigurator {
    let icon = getMessangerIcon(messanger.type)
    let cell = ContactItemCellConfigurator(icon: icon)
    cell.title.value = messanger.link.absoluteString
    cell.tapAction = {
      print("open \(messanger.link)")
    }
    cell.appearanceService = currentAppearanceService
    return cell
  }
  
  private func getMessangerIcon(_ messangerType: MessangerContactType) -> UIImage {
    switch messangerType {
    case .telegram: return AssetsFactory.telegram
    }
  }
}
