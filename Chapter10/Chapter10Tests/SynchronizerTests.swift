//
//  SynchronizerTests.swift
//  Chapter10Tests
//
//  Created by Donny Wals on 20/03/2023.
//

import Foundation
import XCTest
@testable import Chapter10

class SynchronizerTests: XCTestCase {
  func test_valueChangedLoop() async {
    let synchronizer = Synchronizer()
    synchronizer.synchronize()

    var expectedCount = 2

    for await value in synchronizer.$newsItems.values {
      if value.count == expectedCount {
        break
      }
    }
  }
  
  func test_valueChangedClosure() {
    let expect = expectation(description: "Expected synchronizer to complete")
    
    let synchronizer = Synchronizer()
    synchronizer.onComplete = {
      XCTAssert(synchronizer.newsItems.count == 2)
      expect.fulfill()
    }
    
    synchronizer.synchronize()
    waitForExpectations(timeout: 1)
  }
  
  func test_predicateExpectation() {
    let synchronizer = Synchronizer()
    let predicate = NSPredicate(block: { _, _ in
      return synchronizer.newsItems.count == 2
    })
    let expect = expectation(for: predicate, evaluatedWith: nil)
    synchronizer.synchronize()
    waitForExpectations(timeout: 2)
  }
}
