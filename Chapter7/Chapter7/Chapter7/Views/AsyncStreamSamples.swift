//
//  AsyncStreamSamples.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI

struct AsyncStreamSamples: View {
  let locationProvider1 = LocationProvider1()
  let locationProvider2 = LocationProvider2()
  
  var body: some View {
    VStack(spacing: 8) {
      Button("Run first stream") {
        Task {
          let stream = AsyncStreams.makeStream(values: 10)
          
          for await value in stream {
            print(value)
          }
          
          print("stream ended")
        }
      }
      
      Button("Yielding stream") {
        Task {
          let stream = AsyncStreams.simpleYieldingStream()
          
          for await value in stream {
            print("received \(value)")
          }
        }
      }
      
      Button("Location provider") {
        Task {
          let stream = locationProvider1.startUpdatingLocation()
          for await value in stream {
            print(value)
          }
        }
      }
      
      Button("Double iteration on stream") {
        let seq1 = locationProvider1.startUpdatingLocation()
        let seq2 = locationProvider1.startUpdatingLocation()

        Task {
          for await location in seq1 {
            print("seq1", location)
          }
        }

        Task {
          for await location in seq2 {
            print("seq2", location)
          }
        }
      }
      
      Button("Double iteration on reused stream") {
        Task {
          let seq1 = await locationProvider2.startUpdatingLocation()
          let seq2 = await locationProvider2.startUpdatingLocation()
          
          Task {
            for await location in seq1 {
              print("seq1", location)
            }
          }
          
          Task {
            for await location in seq2 {
              print("seq2", location)
            }
          }
        }
      }
    }.padding()
  }
}
