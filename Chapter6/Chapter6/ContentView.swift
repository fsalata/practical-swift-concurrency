//
//  ContentView.swift
//  Chapter6
//
//  Created by Donny Wals on 05/04/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button("Run unsafe date formatters") {
        let cache = DateFormattersUnsafe()

        DispatchQueue.concurrentPerform(iterations: 10) { _ in
          let formatters = ["YYYY", "YYYY-MM", "YYYY-MM-dd"]
          
          let _ = cache.formatter(using: formatters.randomElement()!)
        }
      }
      
      Button("Run read only date formatters") {
        let cache = DateFormattersUnsafe()
        let formatters = ["YYYY", "YYYY-MM", "YYYY-MM-dd"]

        for format in formatters {
          let _ = cache.formatter(using: format)
        }

        DispatchQueue.concurrentPerform(iterations: 10) { _ in
          let _ = cache.formatter(using: formatters.randomElement()!)
        }
      }
      
      Button("Run NSLock version of date formatters") {
        let cache = DateFormattersLocked()

        DispatchQueue.concurrentPerform(iterations: 10) { _ in
          let formatters = ["YYYY", "YYYY-MM", "YYYY-MM-dd"]
          
          let _ = cache.formatter(using: formatters.randomElement()!)
        }
      }
      
      Button("Run Actor version of date formatters") {
        let cache = DateFormatters()

        DispatchQueue.concurrentPerform(iterations: 10) { _ in
          let formatters = ["YYYY", "YYYY-MM", "YYYY-MM-dd"]
          
          Task.detached {
            let _ = await cache.formatter(using: formatters.randomElement()!)
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
