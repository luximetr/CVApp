//
//  SkillsListVC.swift
//  CVClip
//
//  Created by Oleksandr Orlov on 23.06.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillsListVC: ScreenController {
  
  // MARK: - UI elements
  
  private let selfView: SkillsListView
  
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
    selfView.displayCV(createMockCV())
  }
  
  private func createMockCV() -> CV {
    return CV(
      id: "mockCVId",
      userInfo: UserInfo(
        avatarURL: URL(string: "https://www.cheatsheet.com/wp-content/uploads/2020/08/Matt-LeBlanc-1-1024x653.jpg"),
        name: "Matt Leblanc",
        role: "Actor"
      ),
      contacts: Contacts(
        phones: [],
        emails: ["matt.leblanc@gmail.com"],
        messangers: []
      ),
      experience: [
        Experience(
          dateStart: createDate(year: 2019, month: 4, day: 5),
          dateEnd: nil,
          companyName: "Warner Bros. Television"
        )
      ],
      numbers: [],
      skills: []
    )
  }
  
  private func createDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
  }
}
