//
//  ProgressSequenceTests.swift
//  Chapter10Tests
//
//  Created by Donny Wals on 17/03/2023.
//

import Foundation
import XCTest
@testable import Chapter10

class ProgressSequenceTests: XCTestCase {
  func test_sequenceCompletesWithValidValues() async throws {
    let generator = ProgressSequence()
    
    var lastValue: Double? = nil
    
    for await value in generator.run() {
      if let lastValue {
        XCTAssert(value >= lastValue)
      }
      
      XCTAssert(value >= 0)
      XCTAssert(value <= 1)
      
      lastValue = value
    }
    
    let value = try XCTUnwrap(lastValue)
    XCTAssert(value >= 1)
  }
}
