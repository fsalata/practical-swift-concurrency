//
//  ContentView.swift
//  Chapter5
//
//  Created by Donny Wals on 05/04/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var searchFeature = SearchFeature()
  let sample = CombineToAsync()
  
  var body: some View {
    VStack {
      Button("Run checked bad example") {
        Task {
          await Continuations().runCheckedBadExample()
        }
      }
      
      Button("Run unsafe bad example") {
        Task {
          await Continuations().runUnsafeBadExample()
        }
      }
      
      Text("Result obtained via: \(searchFeature.results.first ?? "No result")")
      Button("Run search example") {
        // Use a random string as search input to simulate user typing
        searchFeature.searchText = UUID().uuidString
      }
      
      // Prints result to the console
      Button("Fetch homepage with Combine") {
        sample.fetchHomePage()
      }
      
      // Prints result to the console
      Button("Fetch homepage with Concurrency") {
        sample.fetchHomePageAsync()
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
