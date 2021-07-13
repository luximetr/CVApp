//
//  GetNetworkCVService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 09.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

class GetNetworkCVService {
  
  // MARK: - Dependencies
  
  private let getNetworkCVWebAPIWorker: GetNetworkCVWebAPIWorker
  private let cvCacheWorker: NetworkCVCacheWorker
  
  // MARK: - Life cycle
  
  init(getNetworkCVWebAPIWorker: GetNetworkCVWebAPIWorker,
       cvCacheWorker: NetworkCVCacheWorker
  ) {
    self.getNetworkCVWebAPIWorker = getNetworkCVWebAPIWorker
    self.cvCacheWorker = cvCacheWorker
  }
  
  // MARK: - Get CV
  
  func getCV(cvId: CVIdType, completion: @escaping Completion) {
    getNetworkCVWebAPIWorker.getCVs(
      cvId: cvId,
      completion: { webAPIResult in
        let result = ServiceResultConvertor().toServiceResult(webAPIResult)
        DispatchQueue.main.async {
          completion(result)
        }
      }
    )
  }
  
  func getCachedCV(cvId: CVIdType) -> CV? {
    return cvCacheWorker.fetchCV(cvId: cvId)
  }
  
  // MARK: - Typealiases
  
  typealias Completion = (ServiceResult<CV>) -> Void
}
