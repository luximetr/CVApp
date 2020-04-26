//
//  TempFile.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

struct TempFile<T> {
  let mimeType: MimeType
  let value: T
}
