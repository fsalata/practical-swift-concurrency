//
//  Chapter10Tests.swift
//  Chapter10Tests
//
//  Created by Donny Wals on 15/03/2023.
//

import XCTest
@testable import Chapter10

final class SongGeneratorTests: XCTestCase {
  var generator: SongGenerator!
  
  override func setUp() {
    generator = SongGenerator()
  }
  
  func test_callbackBased() {
    let expect = expectation(description: "Expect song to be generated")
    
    generator.generate { result in
      expect.fulfill()
    }
    
    waitForExpectations(timeout: 0.5)
  }
  
  func test_asyncBased() async throws {
    let song = try await generator.generate()
  }
}
