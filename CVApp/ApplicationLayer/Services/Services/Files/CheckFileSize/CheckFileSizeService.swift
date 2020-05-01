//
//  CheckFileSizeService.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 26/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class CheckFileSizeService {
  
  // MARK: - Dependencies
  
  private let fileSizeConvertor = FileSizeConvertor()
  private let imageFileConvertor = ImageFileConvertor()
  private let stringsLocalizeService: StringsLocalizeService
  
  // MARK: - Life cycle
  
  init(stringsLocalizeService: StringsLocalizeService) {
    self.stringsLocalizeService = stringsLocalizeService
  }
  
  // MARK: - Check file size
  
  func checkFileSize(_ file: ImageFile, maxMBs: Double) -> ServiceResult<Any?> {
    guard let fileData = imageFileConvertor.toData(imageFile: file) else {
      return .failure(createCanNotConvertToDataError())
    }
    let fileBytesSize = fileData.count
    let maxFileSizeInBytes = fileSizeConvertor.convertMegabytesToBytes(maxMBs)
    guard fileBytesSize <= maxFileSizeInBytes else {
      return .failure(createFileToBigError(maxFileSizeInBytes: maxFileSizeInBytes))
    }
    return .success(nil)
  }
  
  // MARK: - Errors
  
  private func createCanNotConvertToDataError() -> ServiceError {
    return ServiceError(message: "Can not convert to data at \(self)")
  }
  
  private func createFileToBigError(maxFileSizeInBytes: Int) -> ServiceError {
    let maxFileSizeString = fileSizeConvertor.convertBytesToString(maxFileSizeInBytes)
    let message =  getLocalizedString(key: "too_big_file_error.message", maxFileSizeString)
    return ServiceError(message: message)
  }
  
  // MARK: - Localized strings
  
  private func getLocalizedString(key: String, _ args: CVarArg...) -> String {
    return stringsLocalizeService.getLocalizedString(key: key, args: args)
  }
  
}
