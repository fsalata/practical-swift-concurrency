//
//  ProgressSequence.swift
//  Chapter10
//
//  Created by Donny Wals on 17/03/2023.
//

import Foundation

class ProgressSequence {
  func run() -> AsyncStream<Double> {
    var progress: Double = 0.0
    
    return AsyncStream(unfolding: {
      guard progress <= 1 else {
        return nil
      }
      
      do {
        try await Task.sleep(for: .milliseconds((0..<500).randomElement()!))
      } catch {
          // ... ignoring errors
      }
      
      progress += 0.05
      return progress
    })
  }
}

class NumbersSequence {
  func run() -> AsyncStream<Int> {
    var number = 0
    
    return AsyncStream(unfolding: {
      number += 1
      return number
    })
  }
}
