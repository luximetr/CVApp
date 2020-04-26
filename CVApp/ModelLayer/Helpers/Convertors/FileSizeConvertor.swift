//
//  FileSizeConvertor.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class FileSizeConvertor {
  
  // MARK: - Dependencies
  
  private let byteCountFormatter: ByteCountFormatter = {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useKB, .useMB]
    formatter.countStyle = .binary
    return formatter
  }()
  
  // MARK: - Mb -> Bytes
  
  func convertMegabytesToBytes(_ megabytes: Double) -> Int {
    let megabytesDecimal = Decimal(megabytes)
    let bytesInKBytes = Decimal(integerLiteral: 1024)
    let kBytesInMBytes = Decimal(integerLiteral: 1024)
    let result = (megabytesDecimal * bytesInKBytes * kBytesInMBytes) as NSDecimalNumber
    return Int(truncating: result)
  }
  
  // MARK: - Bytes -> String
  
  func convertBytesToString(_ bytes: Int) -> String {
    return byteCountFormatter.string(fromByteCount: Int64(bytes))
  }
  
}
