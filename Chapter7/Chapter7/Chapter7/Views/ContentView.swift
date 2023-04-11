//
//  ContentView.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      CSVSamples()
        .tabItem({
          VStack {
            Image(systemName: "list.dash")
            Text("CSV Samples")
          }
        })
      
      AsyncStreamSamples()
        .tabItem({
          VStack {
            Image(systemName: "water.waves")
            Text("Async Streams")
          }
        })
      
      WebsocketSamples()
        .tabItem({
          VStack {
            Image(systemName: "globe")
            Text("Websockets")
          }
        })
      
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
