//
//  SkillGroupJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class SkillGroupJSONConvertor {
  
  func toSkillGroup(json: JSON) -> SkillGroup? {
    guard let name = json["name"] as? String else { return nil }
    guard let skills = json["skills"] as? [String] else { return nil }
    guard !skills.isEmpty else { return nil }
    
    return SkillGroup(
      name: name,
      skills: skills)
  }
}
