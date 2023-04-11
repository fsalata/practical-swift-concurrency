//
//  SocketStream.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation

typealias WebSocketStream = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>

class SocketStream: AsyncSequence {
  typealias AsyncIterator = WebSocketStream.Iterator
  typealias Element = URLSessionWebSocketTask.Message
  
  private var continuation: WebSocketStream.Continuation?
  private let task: URLSessionWebSocketTask
  
  private lazy var continuationStream: WebSocketStream = {
    return WebSocketStream { continuation in
      self.continuation = continuation
      
      Task {
        var isAlive = true
        
        while isAlive && task.closeCode == .invalid {
          do {
            let value = try await task.receive()
            continuation.yield(value)
          } catch {
            continuation.finish(throwing: error)
            isAlive = false
          }
        }
      }
    }
  }()
  
  private lazy var stream: WebSocketStream = {
    return WebSocketStream { continuation in
      self.continuation = continuation
      waitForNextValue()
    }
  }()
  
  init(task: URLSessionWebSocketTask) {
    self.task = task
    task.resume()
  }
  
  deinit {
    Task {
      try await cancel()
    }
  }
  
  func makeAsyncIterator() -> AsyncIterator {
    return stream.makeAsyncIterator()
  }
  
  func cancel() async throws {
    task.cancel(with: .goingAway, reason: nil)
    continuation?.finish()
  }
  
  private func waitForNextValue() {
    guard task.closeCode == .invalid else {
      continuation?.finish()
      return
    }
    
    task.receive(completionHandler: { [weak self] result in
      guard let continuation = self?.continuation else {
        return
      }
      
      do {
        let message = try result.get()
        continuation.yield(message)
        self?.waitForNextValue()
      } catch {
        continuation.finish(throwing: error)
      }
    })
  }
  }
