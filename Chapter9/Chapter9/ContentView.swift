//
//  ContentView.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      AsyncLetView()
        .tabItem({
          VStack {
            Image(systemName: "1.circle")
            Text("Async let")
          }
        })
      
      TaskGroupView()
        .tabItem({
          VStack {
            Image(systemName: "2.circle")
            Text("Task Group")
          }
        })
      
      AdvancedTaskGroupView()
        .tabItem({
          VStack {
            Image(systemName: "3.circle")
            Text("Advanced Task Group")
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
