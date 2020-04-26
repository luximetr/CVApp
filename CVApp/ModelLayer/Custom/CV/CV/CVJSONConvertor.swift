//
//  CVJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CVJSONConvertor {
  
  // MARK: - Dependencies
  
  private let userInfoJSONConvertor = UserInfoJSONConvertor()
  private let contactsJSONConvertor = ContactsJSONConvertor()
  private let experienceJSONConvertor = ExperienceJSONConvertor()
  private let numberJSONConvertor = UserNumberJSONConvertor()
  private let skillJSONConvertor = SkillGroupJSONConvertor()
  
  // MARK: - JSON -> CV
  
  func toCV(json: JSON) -> CV? {
    guard let id = json["id"] as? CVIdType else { return nil }
    guard let userInfo = parseUserInfo(json: json) else { return nil }
    guard let contacts = parseContacts(json: json) else { return nil }
    guard let experience = parseExperience(json: json) else { return nil }
    guard let numbers = parseNumbers(json: json) else { return nil }
    guard let skills = parseSkills(json: json) else { return nil }
    
    return CV(
      id: id,
      userInfo: userInfo,
      contacts: contacts,
      experience: experience,
      numbers: numbers,
      skills: skills)
  }
  
  // MARK: - Parse user info
  
  private func parseUserInfo(json: JSON) -> UserInfo? {
    guard let userInfoJSON = json["userInfo"] as? JSON else { return nil }
    return userInfoJSONConvertor.toUserInfo(json: userInfoJSON)
  }
  
  // MARK: - Parse contacts
  
  private func parseContacts(json: JSON) -> Contacts? {
    guard let contactsJSON = json["contacts"] as? JSON else { return nil }
    return contactsJSONConvertor.toContacts(json: contactsJSON)
  }
  
  // MARK: - Parse experience
  
  private func parseExperience(json: JSON) -> [Experience]? {
    guard let experiencesJSONs = json["experience"] as? [JSON] else { return nil }
    let experiences = experiencesJSONs.compactMap { experienceJSONConvertor.toExperience(json: $0) }
    guard !experiences.isEmpty else { return nil }
    return experiences
  }
  
  // MARK: - Parse numbers
  
  private func parseNumbers(json: JSON) -> [UserNumber]? {
    guard let numbersJSONs = json["numbers"] as? [JSON] else { return nil }
    let numbers = numbersJSONs.compactMap { numberJSONConvertor.toUserNumber(json: $0) }
    guard !numbers.isEmpty else { return nil }
    return numbers
  }
  
  // MARK: - Parse skills
  
  private func parseSkills(json: JSON) -> [SkillGroup]? {
    guard let skillsJSONs = json["skills"] as? [JSON] else { return nil }
    let skills = skillsJSONs.compactMap { skillJSONConvertor.toSkillGroup(json: $0) }
    guard !skills.isEmpty else { return nil }
    return skills
  }
  
  // MARK: - To JSON
  
  func toJSON(cv: CV) -> JSON {
    var json: JSON = [:]
    json["id"] = cv.id
    json["userInfo"] = userInfoJSONConvertor.toJSON(userInfo: cv.userInfo)
    json["contacts"] = contactsJSONConvertor.toJSON(contacts: cv.contacts)
    json["experience"] = toJSONs(experiences: cv.experience)
    json["numbers"] = toJSONs(numbers: cv.numbers)
    json["skills"] = toJSONs(skills: cv.skills)
    return json
  }
  
  private func toJSONs(experiences: [Experience]) -> [JSON] {
    return experiences.map { experienceJSONConvertor.toJSON(experience: $0) }
  }
  
  private func toJSONs(numbers: [UserNumber]) -> [JSON] {
    return numbers.map { numberJSONConvertor.toJSON(userNumber: $0) }
  }
  
  private func toJSONs(skills: [SkillGroup]) -> [JSON] {
    return skills.map { skillJSONConvertor.toJSON(skillGroup: $0) }
  }
  
  func toJSON(avatarURL: URL) -> JSON {
    var json: JSON = [:]
    json["userInfo"] = userInfoJSONConvertor.toJSON(avatarURL: avatarURL)
    return json
  }
}
