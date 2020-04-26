//
//  CV.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

typealias CVIdType = String

struct CV {
  let id: CVIdType
  var userInfo: UserInfo
  let contacts: Contacts
  let experience: [Experience]
  let numbers: [UserNumber]
  let skills: [SkillGroup]
}


