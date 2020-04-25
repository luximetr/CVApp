//
//  ContactsJSONConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class ContactsJSONConvertor {
  
  // MARK: - Dependencies
  
  private let messangerJSONConvertor = MessangerContactJSONConvertor()
  
  // MARK: - JSON -> Contacts
  
  func toContacts(json: JSON) -> Contacts? {
    guard let phones = json["phones"] as? [String] else { return nil }
    guard let emails = json["emails"] as? [String] else { return nil }
    guard let messangers = parseMessangers(json: json) else { return nil }
    
    return Contacts(
      phones: phones,
      emails: emails,
      messangers: messangers)
  }
  
  // MARK: - Parse messangers
  
  private func parseMessangers(json: JSON) -> [MessangerContact]? {
    guard let messangersJSONs = json["messangers"] as? [JSON] else { return nil }
    let messangers = messangersJSONs.compactMap { messangerJSONConvertor.toMessangerContact(json: $0) }
    guard !messangers.isEmpty else { return nil }
    return messangers
  }
  
  // MARK: - Contacts -> JSON
  
  func toJSON(contacts: Contacts) -> JSON {
    var json: JSON = [:]
    json["phones"] = contacts.phones
    json["emails"] = contacts.emails
    json["messangers"] = toJSON(messangers: contacts.messangers)
    return json
  }
  
  private func toJSON(messangers: [MessangerContact]) -> [JSON] {
    return messangers.map { messangerJSONConvertor.toJSON(messangerContact: $0) }
  }
}
