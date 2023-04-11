//
//  ContentView.swift
//  Chapter11
//
//  Created by Donny Wals on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
  @State var movieFetcher = MovieFetcher()
  @State var moviesCount = 0
  
  var body: some View {
    VStack(spacing: 16) {
      Text("Fetched \(moviesCount) movies")
      Button(action: {
        Task {
          try await movieFetcher.fetchEnrichedMovies(page: 1)
          
          moviesCount = await movieFetcher.fetchedMovies.count
        }
      }, label: {
        Text("Fetch movies")
      })
    }
    .padding()
  }
}
