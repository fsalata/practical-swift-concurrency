//
//  ContentView.swift
//  Snippets
//
//  Created by Donny Wals on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
  @State var isShowingFetchView = false
  
  var body: some View {
    VStack {
      Button("Run with concurrency") {
        Task {
          await awaitWithConcurrency()
        }
      }
      
      Button("Run with a callback") {
        awaitWithoutConcurrency()
      }
      
      Button("Present view with task modifier") {
        isShowingFetchView = true
      }
      
      Button("Run a loop that yields") {
        Task {
          await loopWithYielding()
        }
      }
    }
    .padding()
    .sheet(isPresented: $isShowingFetchView) {
      VStack {
        Text("A simple example view...")
        Button("Dismiss") {
          isShowingFetchView = false
        }
      }
      .padding()
      .task {
        let url = URL(string: "https://practicalswiftconcurrency.com")!
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          let htmlBody = String(data: data, encoding: .utf8)!
          print(htmlBody)
        } catch {
          print(error)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
