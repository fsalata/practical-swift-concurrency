//
//  AsyncLet.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation
import SwiftUI

struct AsyncLetView: View {
  var body: some View {
    VStack(spacing: 8) {
      Button("Run serial network call") {
        Task {
          let samples = AsyncLetSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchDetailsFor_serial(Movie.mock)
          print("Serial call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run unstructured network call") {
        Task {
          let samples = AsyncLetSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchDetailsFor_unstructured(Movie.mock)
          print("Unstructured call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run async let network call") {
        Task {
          let samples = AsyncLetSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchDetailsFor(Movie.mock)
          print("Async let call took \(CACurrentMediaTime() - start) seconds")
        }
      }
    }
  }
}
