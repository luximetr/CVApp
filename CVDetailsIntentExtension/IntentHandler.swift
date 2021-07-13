//
//  IntentHandler.swift
//  CVDetailsIntentExtension
//
//  Created by Oleksandr Orlov on 12.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Intents

class IntentHandler: INExtension, SelectCVIntentHandling {
  
  private let getCVService = GetNetworkCVsWebAPIWorker(session: .shared, requestComposer: URLRequestComposer(baseURL: "https://us-central1-cvapp-8ebd9.cloudfunctions.net"))
  
  func resolveCVDetails(for intent: SelectCVIntent, with completion: @escaping (CVDetailsResolutionResult) -> Void) {
    
  }
  
  func provideCVDetailsOptionsCollection(for intent: SelectCVIntent, with completion: @escaping (INObjectCollection<CVDetails>?, Error?) -> Void) {
    getCVService.getCVs(authToken: "userId") { result in
      switch result {
        case .success(let cvs):
          let cvDetails = cvs.map { CVDetails(identifier: $0.id, display: $0.userInfo.name) }
          let collection = INObjectCollection(items: cvDetails)
          completion(collection, nil)
        case .failure(let failure):
          switch failure {
            case .request(let error):
              completion(nil, error)
            case .response(let error):
              completion(nil, error)
          }
      }
    }
  }
  
  
  override func handler(for intent: INIntent) -> Any {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self
  }
  
}
