//
//  ExperienceJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ExperienceJSONConvertor {
  
  // MARK: - Dependencies
  
  private let dateConvertor = YearDateConvertor()
  
  // MARK: - JSON -> Experiences
  
  func toExperience(json: JSON) -> Experience? {
    guard let dateStartString = json["dateStart"] as? String else { return nil }
    guard let dateStart = dateConvertor.toDate(dateStartString) else { return nil }
    guard let companyName = json["companyName"] as? String else { return nil }
    let dateEndString = json["dateEnd"] as? String
    let dateEnd = dateConvertor.toDate(dateEndString ?? "")
    
    return Experience(
      dateStart: dateStart,
      dateEnd: dateEnd,
      companyName: companyName)
  }
  
}
