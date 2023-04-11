//
//  NumbersSequenceTest.swift
//  Chapter10Tests
//
//  Created by Donny Wals on 17/03/2023.
//

import Foundation
import XCTest
@testable import Chapter10

class NumbersSequenceTests: XCTestCase {
  func test_numbersAreEmitted() async {
    let generator = NumbersSequence()
    var expectedNumbers = [1, 2, 3, 4, 5]
    
    for await value in generator.run() {
      let expected = expectedNumbers.removeFirst()
      XCTAssert(value == expected)
      
      if expectedNumbers.isEmpty || value != expected {
        break
      }
    }
  }
}
