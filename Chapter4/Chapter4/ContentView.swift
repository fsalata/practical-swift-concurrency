//
//  ContentView.swift
//  Chapter4
//
//  Created by Donny Wals on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button("Run the task blocking sample") {
        TaskRunner.run(tasks: 100)
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
