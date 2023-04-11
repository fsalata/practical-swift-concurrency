//
//  Continuations.swift
//  Chapter5
//
//  Created by Donny Wals on 05/04/2023.
//

import Foundation

struct Continuations {
  func runCheckedBadExample() async {
    let _ = await withCheckedContinuation { continuation in
      callbackFunction(shouldSucceed: true) { result in
        guard let success = try? result.get() else {
          continuation.resume(returning: "Failed")
          return
        }
        
        continuation.resume(returning: success)
        continuation.resume(returning: success)
      }
    }
  }
  
  func runUnsafeBadExample() async {
    let _ = await withUnsafeContinuation { continuation in
      callbackFunction(shouldSucceed: true) { result in
        guard let success = try? result.get() else {
          continuation.resume(returning: "Failed")
          return
        }
        
        continuation.resume(returning: success)
        continuation.resume(returning: success)
      }
    }
  }
  
  func callbackFunction(shouldSucceed: Bool, _ completion: @escaping (Result<String, Error>) -> Void) {
    // we're just calling our completion with a mock result here
    if shouldSucceed {
      completion(.success("Success!"))
    } else {
      completion(.failure(ContinuationFailure.mockError))
    }
  }
}

enum ContinuationFailure: Error {
  case mockError
}
