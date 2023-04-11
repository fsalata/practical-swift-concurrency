//
//  ContentView.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      MainView()
        .tabItem({
          VStack {
            Image(systemName: "globe")
            Text("Main samples")
          }
        })
      
      SubjectSample()
        .tabItem({
          VStack {
            Image(systemName: "one.lane")
            Text("Subject lifecycle")
          }
        })
      
      SequenceSample()
        .tabItem({
          VStack {
            Image(systemName: "two.lane")
            Text("Sequence lifecycle")
          }
        })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
