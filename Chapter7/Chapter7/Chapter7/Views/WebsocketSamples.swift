//
//  WebsocketSamples.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI

struct WebsocketSamples: View {
  var body: some View {
    VStack(spacing: 8) {
      Button("Run standard example") {
        // don't forget to run your local server for this. See the README.md in this chapter's folder.
        Websockets.runStandardExample()
      }
      
      Button("Async socket iteration") {
        Task {
          do {
            for try await message in Websockets.getAsyncStream() {
              // handle incoming messages
            }
          } catch {
            // handle errors
          }
        }
      }
      
      Button("Open and close connection") {
        Task {
          await Websockets.runSampleWithClosedConnection()
        }
      }
      
      Button("SocketStream sample") {
        let url = URL(string: "ws://127.0.0.1:9090")!
        let socketConnection = URLSession.shared.webSocketTask(with: url)
        let stream = SocketStream(task: socketConnection)
        
        Task {
          try await Task.sleep(for: .seconds(5))
          try await stream.cancel()
        }

        Task {
          do {
            for try await message in stream {
              print("incoming message", message)
            }
          } catch {
            // handle error
          }
          
          print("this will be printed once the stream ends")
        }
      }
    }
  }
}
