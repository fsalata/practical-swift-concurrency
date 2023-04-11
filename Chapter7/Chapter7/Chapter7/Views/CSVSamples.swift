//
//  CSVSamples.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI

struct CSVSamples: View {
  var body: some View {
    VStack(spacing: 8) {
      Button("Run synchronous CSV reader") {
        CSVReader.runSynchronous()
      }
      
      Button("Run CSV reader with async for loop") {
        Task {
          await CSVReader.runAsyncLoop()
        }
      }
      
      Button("Run two loops sequentially") {
        Task {
          let csvURL = URL(string: "http://127.0.0.1:8080/cars.csv")!
          
          print("about to process...")
          
          for try await _ in csvURL.lines {
            print("Loop one received line...")
          }
          
          print("processed first sequence...")
          
          for try await _ in csvURL.lines {
            print("Loop two received line...")
          }
          
          print("processed second sequence...")
        }
      }
      
      Button("Run two loops in parallel") {
        Task {
          let csvURL = URL(string: "http://127.0.0.1:8080/cars.csv")!
          
          let task1 = Task {
            for try await _ in csvURL.lines {
              print("Loop one received line...")
            }
          }
          
          let task2 = Task {
            for try await _ in csvURL.lines {
              print("Loop two received line...")
            }
          }
          
          try await (task1.value, task2.value)
          print("both sequences are processed")
        }
      }
    }.padding()
  }
}
