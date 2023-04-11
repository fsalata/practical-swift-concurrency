//
//  DateFormatters.swift
//  Chapter6
//
//  Created by Donny Wals on 05/04/2023.
//

import Foundation

// Unsafe version of DateFormatters object
class DateFormattersUnsafe {
  private var formatters: [String: DateFormatter] = [:]
  
  func formatter(using dateFormat: String) -> DateFormatter {
    if let formatter = formatters[dateFormat] {
      return formatter
    }
    
    let newFormatter = DateFormatter()
    newFormatter.dateFormat = dateFormat
    formatters[dateFormat] = newFormatter
    
    return newFormatter
  }
}

// Version of DateFormatters object with NSLock
class DateFormattersLocked {
  private var formatters: [String: DateFormatter] = [:]
  private var lock = NSLock()
  
  func formatter(using dateFormat: String) -> DateFormatter {
    lock.lock()
    defer { lock.unlock() }
    
    if let formatter = formatters[dateFormat] {
      return formatter
    }
    
    let newFormatter = DateFormatter()
    newFormatter.dateFormat = dateFormat
    formatters[dateFormat] = newFormatter
    
    return newFormatter
  }
}

actor DateFormatters {
  private var formatters: [String: DateFormatter] = [:]
  
  func formatter(using dateFormat: String) -> DateFormatter {
    if let formatter = formatters[dateFormat] {
      return formatter
    }
    
    let newFormatter = DateFormatter()
    newFormatter.dateFormat = dateFormat
    formatters[dateFormat] = newFormatter
    
    return newFormatter
  }
}
