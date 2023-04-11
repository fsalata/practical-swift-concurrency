//
//  Websockets.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation

struct Websockets {
  static func runStandardExample() {
    let url = URL(string: "ws://127.0.0.1:9090")!
    let socketConnection = URLSession.shared.webSocketTask(with: url)
    socketConnection.resume()
    
    func setReceiveHandler() {
      socketConnection.receive { result in
        defer { setReceiveHandler() }
        
        do {
          let message = try result.get()
          switch message {
          case let .string(string):
            print("incoming message", string)
          case let .data(data):
            print("incoming message", data)
          @unknown default:
            print("unkown message received")
          }
        } catch {
          // handle the error
          print(error)
        }
      }
    }
    
    setReceiveHandler()
  }
  
  static func getAsyncStream() -> WebSocketStream {
    let url = URL(string: "ws://127.0.0.1:9090")!
    let socketConnection = URLSession.shared.webSocketTask(with: url)
    socketConnection.resume()
    
    return socketConnection.stream
  }
  
  static func runSampleWithClosedConnection() async {
    let url = URL(string: "ws://127.0.0.1:9090")!
    let socketConnection = URLSession.shared.webSocketTask(with: url)
    socketConnection.resume()
    
    Task {
      try await Task.sleep(for: .seconds(5))
      socketConnection.cancel(with: .goingAway, reason: nil)
    }

    Task {
      do {
        for try await message in socketConnection.stream {
          print("received message", message)
        }
      } catch {
        // handle error
      }

      print("this would never be printed")
    }
  }
}

extension URLSessionWebSocketTask {
  var stream: WebSocketStream {
    return WebSocketStream { continuation in
      Task {
        var isAlive = true
        
        while isAlive && closeCode == .invalid {
          do {
            let value = try await receive()
            continuation.yield(value)
          } catch {
            continuation.finish(throwing: error)
            isAlive = false
          }
        }
      }
    }
  }
}
