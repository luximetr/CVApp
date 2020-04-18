//
//  YearDateConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class YearDateConvertor {
  
  // MARK: - Dependencies
  
  private let dateFormatter: DateFormatter
  
  // MARK: - Life cycle
  
  init() {
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
  }
  
  // MARK: - String -> Date
  
  func toDate(_ dateString: String) -> Date? {
    return dateFormatter.date(from: dateString)
  }
}
