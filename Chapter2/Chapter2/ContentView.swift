//
//  ContentView.swift
//  Chapter2
//
//  Created by Donny Wals on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button("Run dispatch sync vs async") {
        performSync()
        performAsync()
      }
      
      Button("Run dispatch group sample") {
        fetchWebsites()
      }
      
      Button("Stress test cache 1") {
        let cache = SimpleCache<String, UUID>()
        
        DispatchQueue.concurrentPerform(iterations: 20) { index in
          cache.setValue(UUID(), forKey: "item-\(index)")
          
          if index % 2 == 0 {
            if let value = cache.getValue(forKey: "item-\(index)") {
              print(value.uuidString)
            }
          }
        }
      }
      
      Button("Stress test cache 2") {
        let cache = SimpleCache2<String, UUID>()
        
        DispatchQueue.concurrentPerform(iterations: 20) { index in
          cache.setValue(UUID(), forKey: "item-\(index)")
          
          if index % 2 == 0 {
            if let value = cache.getValue(forKey: "item-\(index)") {
              print(value.uuidString)
            }
          }
        }
      }
      
      Button("Stress test cache 3") {
        let cache = SimpleCache3<String, UUID>()
        
        DispatchQueue.concurrentPerform(iterations: 20) { index in
          cache.setValue(UUID(), forKey: "item-\(index)")
          
          if index % 2 == 0 {
            if let value = cache.getValue(forKey: "item-\(index)") {
              print(value.uuidString)
            }
          }
        }
      }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
