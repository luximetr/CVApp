//
//  SkillGroupJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class SkillGroupJSONConvertor {
  
  // MARK: - JSON -> SkillGroup
  
  func toSkillGroup(json: JSON) -> SkillGroup? {
    guard let name = json["name"] as? String else { return nil }
    guard let skills = json["skills"] as? [String] else { return nil }
    guard !skills.isEmpty else { return nil }
    
    return SkillGroup(
      name: name,
      skills: skills)
  }
  
  // MARK: - SkillGroup -> JSON
  
  func toJSON(skillGroup: SkillGroup) -> JSON {
    var json: JSON = [:]
    json["name"] = skillGroup.name
    json["skills"] = skillGroup.skills
    return json
  }
}
