//
//  Bindable.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 15/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

class Bindable<T> {
  
  typealias ListenerCallback = (T) -> Void
  typealias ValueType = T
  
  private var listener: ListenerCallback?
  
  private var _value: ValueType
  var value: ValueType {
    set {
      _value = newValue
      listener?(newValue)
    }
    get {
      return _value
    }
  }
  
  init(_ value: ValueType) {
    self._value = value
    self.value = value
  }
  
  func bind(listener: @escaping ListenerCallback) {
    self.listener = listener
  }
  
}
