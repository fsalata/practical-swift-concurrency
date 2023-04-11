//
//  AsyncStreams.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation

struct AsyncStreams {
  static func makeStream(values: Int) -> AsyncStream<String> {
    var valueCount = 0
    return AsyncStream(unfolding: {
      let value = await produceValue(shouldTerminate: valueCount == values)
      valueCount += 1
      return value
    })
  }

  static func produceValue(shouldTerminate: Bool) async -> String? {
    guard !shouldTerminate else {
      return nil
    }
    
    return UUID().uuidString
  }
  
  static func simpleYieldingStream() -> AsyncStream<Int> {
    let stream = AsyncStream { continuation in
        print("will start yielding")
        continuation.yield(1)
        continuation.yield(2)
        continuation.yield(3)
        continuation.finish()
        print("finished the stream")
    }
    
    return stream
  }
}
