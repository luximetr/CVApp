//
//  URLSessionWebAPIWorker.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 11/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class URLSessionWebAPIWorker {
  
  let session: URLSession
  let requestComposer: URLRequestComposer
  
  init(session: URLSession, requestComposer: URLRequestComposer) {
    self.session = session
    self.requestComposer = requestComposer
  }
  
}
