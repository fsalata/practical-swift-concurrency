//
//  MainView.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI

struct MainView: View {
  let locationProvider = LocationProvider()
  let lifecycles = Lifecycles()
  
  var body: some View {
    VStack(spacing: 8) {
      Button("Run location provider") {
        Task {
          let stream = locationProvider.startUpdatingLocation()
          for await value in stream {
            print("seq 1", value)
          }
        }
        
        Task {
          let stream = locationProvider.startUpdatingLocation()
          for await value in stream {
            print("seq 2", value)
          }
        }
      }
      
      Button("Run nonStoredCancellable") {
        lifecycles.nonStoredCancellable()
      }
      
      Button("Run storedCancellable") {
        lifecycles.storedCancellable()
      }
    }
    .padding()
  }
}
